import 'dart:io';

import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  static const routeName = '/gallery-screen';
  List<File> _images = [];

  bool isNOImages = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.yellow[50],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: Colors.blueGrey[900],
        padding: EdgeInsets.only(top: 40, bottom: 20),
        child: isNOImages
            ? Center(
                widthFactor: 100,
                heightFactor: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 90),
                      title: Icon(
                        Icons.image_search,
                        color: Colors.yellow[50],
                        size: 100.0,
                      ),
                      subtitle: Text(
                        'No images yet',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Add',
                      ),
                      color: Colors.yellow[100],
                      height: 70,
                    ),
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (ctx, index) => Container(
                  child: Text('grid piece'),
                ),
                itemCount: _images.length,
              ),
      ),
    );
  }
}
