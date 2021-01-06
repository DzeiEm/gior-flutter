import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gior/providers/gallery_images_pr.dart';
import 'package:gior/screens/add_image_screen.dart';
import 'package:gior/screens/image_details_screen.dart';
import 'package:gior/screens/main%20_screens/settings.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery-screen';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool isNOImages = true;

  @override
  void initState() {
    // load gallery
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('--------GALLERY SCREEN BUILD----------');

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
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Center(
          widthFactor: 100,
          heightFactor: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Gallery',
                  style: TextStyle(fontSize: 24, color: Colors.yellow[50])),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _buildImageGrid(context),
              ),
              FlatButton(
                minWidth: double.infinity,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddImageScreen.routeName);
                },
                child: Text(
                  'Add',
                ),
                color: Colors.yellow[100],
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildImageGrid(BuildContext context) {
  return FutureBuilder(
    future:
        Provider.of<ImagesProvider>(context, listen: false).fetchAndSetGalleryImages(),
    builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
        ? Center(child: CircularProgressIndicator())
        : Consumer<ImagesProvider>(
            child: ListTile(
              
              contentPadding: EdgeInsets.only(left: 50, right: 20),
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
            builder: (ctx, img, ch) => img.images.length <= 0
                ? ch
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (ctx, index) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: GridTile(
                            child: GestureDetector(
                              child: Image.file(img.images[index].image),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ImageDetailsScreen(
                                          image: img.images[index].image,
                                          title: img.images[index].title,
                                        )));
                              },
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.yellow[50],
                              title: Text(
                                img.images[index].title,
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    itemCount: img.images.length,
                  ),
          ),
  );
}
