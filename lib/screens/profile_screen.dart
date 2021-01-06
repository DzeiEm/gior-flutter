import 'package:flutter/material.dart';
//
import 'main _screens/settings.dart';
import '../firebase/auth.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Auth _auth = Auth();

  @override
  void initState() {
    _auth.getUser();
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
          onPressed: () => Navigator.of(context).pop(SettingsScreen.routeName),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
        child: FutureBuilder(
          future: _auth.getUserProfileData(),
          builder: (BuildContext ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none)
              return Center(
                child: CircularProgressIndicator(
                  value: 100,
                  strokeWidth: 3,
                  backgroundColor: Colors.blueGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              );

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              print('SNAPSHOT DATA: $snapshot.data');
              return Column(
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
                            style: TextStyle(
                                color: Colors.yellow[50], fontSize: 26),
                          ),
                          Text(data['name'],
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 26)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email:',
                            style: TextStyle(
                                color: Colors.yellow[50], fontSize: 26),
                          ),
                          Text(data['email'],
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 26)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone:',
                            style: TextStyle(
                                color: Colors.yellow[50], fontSize: 26),
                          ),
                          Text(data['phone'],
                              style: TextStyle(
                                  color: Colors.yellow[50], fontSize: 26)),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
