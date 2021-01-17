import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gior/providers/procedures_pr.dart';
import 'package:gior/screens/add_procedure_admin.dart';
import 'package:gior/screens/procedure_details_screen.dart';
import 'package:gior/widget/procedure_item.dart';
import 'package:provider/provider.dart';

class ProcedureListScreen extends StatefulWidget {
  static const routeName = 'procedure-screen';

  @override
  _ProcedureListScreenState createState() => _ProcedureListScreenState();
}

class _ProcedureListScreenState extends State<ProcedureListScreen> {
  var _isInit = true;
  var _isLoding = true;

  @override
  void initState() {
    print('init state procedure list');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('did change dep');
    if (_isInit) {
      setState(() {
        _isLoding = true;
      });

      Provider.of<Procedures>(context, listen: false)
          .fetchAndSetProceduresData()
          .then((_) {
        setState(() {
          _isLoding = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _refreshProcedures() async {
    await Provider.of<Procedures>(context, listen: false)
        .fetchAndSetProceduresData();
  }

  @override
  Widget build(BuildContext context) {
    print('----------PROCEDURE LIST SCREEN-----------');
    final procedures = Provider.of<Procedures>(context);
    final prodList = procedures.procedures;
    var ifAdmin = true;

    void _filterByManicure() {
      // manicure procedures
    }
    void _filterByPedicure() {
      // pedicure procedures
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clean_hands),
            onPressed: _filterByManicure,
            splashColor: Colors.yellowAccent[100],
          ),
          IconButton(
            icon: Icon(Icons.sports_football),
            onPressed: _filterByPedicure,
            splashColor: Colors.yellowAccent[100],
          ),
        ],
        backgroundColor: Colors.blueGrey[800],
        elevation: 5,
        centerTitle: false,
        title: Text(
          'Procedures',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('procedures').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No procedures yet',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'Add it :)',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.white12,
                      child: Text(
                        'Add procedure',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddProcedureScreen.routeName);
                      },
                    ),
                  ],
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot procedures = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProcedureDetailsScreen.routeName, arguments: procedures);
                      },
                      child: ProcedureItem(
                        id: procedures['proID'],
                        title: procedures['title'],
                        description: procedures['description'],
                        price: procedures['price'],
                        // pType: procedures['proType'],
                        // duration: procedures['duration'],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.white12,
                      child: Text(
                        'Add procedure',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddProcedureScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
