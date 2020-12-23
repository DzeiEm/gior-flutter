import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Profile with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createProfile(
      String userId, String email, String name, int phone, int role) async {
    userId = DateTime.now().toIso8601String();
    if (email == 'admin@admin.com') {
      role = 1;
    } else {
      role = 0;
    }
    try {
      if (role == 1) {
        FirebaseFirestore.instance
            .collection('users')
            .doc('admin')
            .collection('1')
            .add({
          'user': userId,
          'email': email,
          'name': name,
          'phone': phone,
          'role': role,
        });
        print('admin profile added:$userId, $email, $name, $phone, $role');
        notifyListeners();
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc()
            .collection('0')
            .add({
          'user': userId,
          'email': email,
          'name': name,
          'phone': phone,
          'role': role,
        });
        print('other profile added:$userId, $email, $name, $phone, $role');
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  void getUserData() async {
    final profile = _firestore.collection('users').doc('admin').get();
    print(profile);
  }
}

// void getMessages() async {
//   final messages = await _firestore.collection('messages').get();
//   for (var message in messages.docs) {
//     print(message.data());
//   }
