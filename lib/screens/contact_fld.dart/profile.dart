import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gior/providers/auth.dart';

final _firestore = FirebaseFirestore.instance;
Auth auth = Auth();
User user = auth.loggedInUser;

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name;
  String email;
  int phone;

  @override
  void initState() {
    auth.getUser();
    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'My profile',
              style: TextStyle(fontSize: 28, color: Colors.yellow[50]),
            ),
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(color: Colors.yellow[50], fontSize: 22),
                    ),
                    Text(
                      '',
                      style: TextStyle(color: Colors.yellow[50]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone:',
                      style: TextStyle(color: Colors.yellow[50], fontSize: 22),
                    ),
                    Text(
                      phone.toString(),
                      style: TextStyle(color: Colors.yellow[50]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email:',
                      style: TextStyle(color: Colors.yellow[50], fontSize: 22),
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(color: Colors.yellow[50]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
