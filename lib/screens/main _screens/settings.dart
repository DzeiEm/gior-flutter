import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';
import 'package:gior/screens/chat_screen.dart';
import 'package:gior/screens/location_screen.dart';
import 'package:gior/screens/profile_screen.dart';
import 'package:gior/screens/deal_screen.dart';
import 'package:gior/screens/gallery_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/ setting-screen';
  @override
  Widget build(BuildContext context) {
    print('----------SETTINGS SCREEN------------');
    Auth _auth = Auth();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        centerTitle: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
              splashColor: Colors.yellow[300],
              icon: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.red[300],
              ),
              onPressed: _auth.autoLogin,),
        ],
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton('Find me here', () {
                    Navigator.of(context).pushNamed(LocationScreen.routeName);
                  }),
                  _buildButton('Chat', () {
                    Navigator.of(context).pushNamed(ChatScreen.routeName);
                  }),
                  _buildButton('Gallery', () {
                    Navigator.of(context).pushNamed(GalleryScreen.routeName);
                  }),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton('Deal', () {
                    Navigator.of(context).pushNamed(DealScreen.routeName);
                  }),
                  _buildButton('My Profile', () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildButton(String text, Function onTap) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.brown[100],
      ),
      height: 100,
      width: 100,
      child: Text(text),
      alignment: Alignment.center,
    ),
    onTap: onTap,
    splashColor: Colors.yellow[200],
  );
}
