import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gior/http/http_exeptions.dart';
import 'package:gior/model/procedure.dart';
import 'package:http/http.dart' as http;

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Procedures extends ChangeNotifier {
  List<Procedure> _procedures = [];
  List<Procedure> get procedures {
    return _procedures;
  }

  // final String userId;
  // Procedures(this.userId, this._procedures);

  Procedure findById(String index) {
    if (_procedures.isNotEmpty) {
      return _procedures.firstWhere((listElement) => listElement.id == index);
    }
  }

  Future<void> fetchAndSetProceduresData([bool filterByUser = false]) async {
    // final filterString =
    //     filterByUser ? 'orderBy="creatorId"equalTo="$userId"' : '';

    final url = 'https://jmepro.firebaseio.com/procedures.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Procedure> loadedProcedures = [];
      extractedData.forEach((prodId, procData) {
        loadedProcedures.add(
          Procedure(
            id: prodId,
            title: procData['title'],
            description: procData['description'],
            pType: procData['proType'],
            price: procData['price'],
            duration: procData['duration'],
          ),
        );
      });
      _procedures = loadedProcedures;
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      // throw error;
    }
  }

  Future<void> addProcedure(Procedure newProcedure) async {
    await _firestore.collection('procedures').add({
      'id': newProcedure.id,
      'title': newProcedure.title,
      'description': newProcedure.description,
      'price': newProcedure.price,
    });

    final url = 'https://jmepro.firebaseio.com/procedures.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': newProcedure.id,
          'title': newProcedure.title,
          'description': newProcedure.description,
          // 'proType': newProcedure.pType, String;as turi buti
          'price': newProcedure.price,
          // 'duration': newProcedure.duration, Sttringas turi buti
          // 'creatorId': userId,
        }),
      );
      // pridedu i local
      final newAddedProcedure = Procedure(
          id: json.decode(response.body)['name'],
          title: newProcedure.title,
          price: newProcedure.price,
          pType: newProcedure.pType,
          description: newProcedure.description,
          duration: newProcedure.duration);

      _procedures.add(newAddedProcedure); // i gala
      // _procedures.insert(0, newProcedure); i pradzia
      print('procedure has  been added');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> editProcedure(String id, Procedure editedProcedure) async {
    //  patch attsakingas uz update'e... t.i jei nesiunciu duomenu, tie duomenys tures senas reiksmes
    final procedureIndex =
        _procedures.indexWhere((procedureElement) => procedureElement.id == id);
    if (procedureIndex >= 0) {
      final url = 'https://jmepro.firebaseio.com/procedures/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': editedProcedure.title,
            'description': editedProcedure.description,
            'proType': editedProcedure.pType,
            'price': editedProcedure.price,
            'duration': editedProcedure.duration,
          }));

      _procedures[procedureIndex] = editedProcedure;
      notifyListeners();
    } else {
      print('no id');
    }
  }

  Future<void> deleteProcedure(String id) async {
    if (id != null) {
      final url = 'https://jmepro.firebaseio.com/procedures/$id.json';
      final existingProcedureIndex =
          _procedures.indexWhere((proc) => proc.id == id);
      var existingProcedure = _procedures[existingProcedureIndex];

      _procedures.removeAt(existingProcedureIndex);
      notifyListeners();
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        // jei iskyla problemu netrinant, tiesiog grazinam ta itema i ta viena kur buvo
        _procedures.insert(existingProcedureIndex, existingProcedure);
        print('procedure $id has NOT been deleted');
        notifyListeners();
        throw HttpException('Could not delete product');
      } else {
        //  jei neiskyla jokiu problemu, betrinant item'a
        existingProcedure = null;
        print('procedure $id has been deleted');
      }
    }
  }
}
