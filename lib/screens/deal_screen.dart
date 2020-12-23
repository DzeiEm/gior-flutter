import 'package:flutter/material.dart';

class DealScreen extends StatelessWidget {
  static const routeName = '/deal-screen';
  bool none = true;

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
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey[900],
        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              none ? 'No Deals for now' : ' See a DeaL',
              style: TextStyle(fontSize: 28, color: Colors.yellow[50]),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  height: 280,
                  width: 350,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey[800],
                  ),
                ),
                Container(
                  height: 180,
                  width: 300,
                  color: Colors.yellow[50],
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 140, vertical: 80),
                  child: Text(
                    '💁‍♀️',
                    style: TextStyle(fontSize: 80),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: none ? Colors.green[100] : Colors.green[800],
                  ),
                  child: IconButton(
                    iconSize: 40,
                    splashColor: Colors.teal,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // accept a deal
                      print('accept tapped');
                    },
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: none ? Colors.red[100] : Colors.red[800],
                  ),
                  child: IconButton(
                    iconSize: 40,
                    splashColor: Colors.teal,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // cancel a deal
                      print('cancel tapped');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  elevation: 7,
                  tooltip: 'make a deal',
                  backgroundColor: Colors.blueGrey[800],
                  splashColor: Colors.teal,
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    //
                    print('make a deal button pressed');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
