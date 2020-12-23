import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey[900],
      body: Container(
        child: Opacity(
          opacity: 0.4,
          child: Stack(
            children: [
              Image.asset('assets/images/login.png'),
              Text(
                'Loding',
                style: TextStyle(fontSize: 26, color: Colors.yellow[100]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
