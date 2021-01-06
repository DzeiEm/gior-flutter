import 'dart:io';

import 'package:flutter/material.dart';

class ImageDetailsScreen extends StatelessWidget {
  static const routeName = '/image-details-screen';
  final File image;
  final String title;
  ImageDetailsScreen({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    print('------------IMAGE DSETAILS SCREEN----------');
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, color: Colors.yellow),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Expanded(
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
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
