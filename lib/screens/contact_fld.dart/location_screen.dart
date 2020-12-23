import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  static const routeName = '/location-screen';
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Find me',
              style: TextStyle(color: Colors.yellow[50], fontSize: 28),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Address:',
                  style: TextStyle(color: Colors.yellow[50], fontSize: 22),
                ),
                Row(
                  children: [
                    Text(
                      'bla bla bla address',
                      style: TextStyle(color: Colors.white70),
                    ),
                    IconButton(
                        color: Colors.yellow[50],
                        icon: Icon(Icons.edit),
                        onPressed: () {}),
                  ],
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
                Row(
                  children: [
                    Text(
                      'Phone',
                      style: TextStyle(color: Colors.white70),
                    ),
                    IconButton(
                        color: Colors.yellow[50],
                        icon: Icon(Icons.edit),
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[200]),
                ),
                GridTileBar(
                  title: Text('you are here'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
