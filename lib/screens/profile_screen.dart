import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';

final _firestore = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Auth _auth = Auth();
  Future<DocumentSnapshot> getData() async {
    final user = await _auth.getUser();
    return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.yellow[50],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            'My profile',
                            style: TextStyle(
                                fontSize: 28, color: Colors.yellow[50]),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.yellow[50],
                                  ),
                                  FloatingActionButton(
                                      backgroundColor: Colors.blueGrey[800],
                                      hoverElevation: 6,
                                      tooltip: 'Add image',
                                      child: Icon(
                                        Icons.add,
                                      ),
                                      onPressed: () {
                                        // Add image
                                        print('profile image added');
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(
                                    color: Colors.yellow[50], fontSize: 22),
                              ),
                              Text(snapshot.data['name'],
                                  style: TextStyle(
                                      color: Colors.pink[100], fontSize: 18,fontStyle: FontStyle.italic)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(
                                    color: Colors.yellow[50], fontSize: 22),
                              ),
                              Text(snapshot.data['email'],
                                  style: TextStyle(
                                      color: Colors.pink[100], fontSize: 18,fontStyle: FontStyle.italic)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone:',
                                style: TextStyle(
                                    color: Colors.yellow[50], fontSize: 22),
                              ),
                              Text(snapshot.data['phone'].toString(),
                                  style: TextStyle(
                                      color: Colors.pink[100], fontSize: 18, fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
