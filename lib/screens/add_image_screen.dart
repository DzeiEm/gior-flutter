import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gior/providers/gallery_images_pr.dart';
import 'package:gior/screens/gallery_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';

class AddImageScreen extends StatefulWidget {
  static const routeName = '/add-image-screen';

  @override
  _AddImageScreenState createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  final _titleController = TextEditingController();
  File _takenImage; // image wich gonna be made
  File _image;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
      //  sito reikia in case kai vartotojas nuejo pasidaryt image'o, bet poto nieko nepadares isejo.
    }
    setState(() {
      _takenImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _takenImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
  }

  void _selectImage(File pickedImage) {
    _image = pickedImage;
  }

  void _saveImage() {
    if (_titleController.text.isEmpty || _image == null) {
      return;
    }
    Provider.of<ImagesProvider>(context, listen: false)
        .addImage(_image, _titleController.text);
    Navigator.of(context).popAndPushNamed(GalleryScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print('-----------ADD IMAGE SCREEN------------');
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                color: Colors.amber,
                width: 350,
                height: 400,
                child: _takenImage != null
                    ? Image.file(
                        _takenImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Text('No image picked'),
              ),
            ),
          ),
          SizedBox(height: 20),
          // textFiel
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.teal[50]),
              decoration: InputDecoration(
                hintText: 'Enter title',
                hintStyle: TextStyle(
                  color: Colors.yellow[50],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow[50]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              cursorColor: Colors.purple,
            ),
          ),
          // Take picture/ cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                height: 100,
                onPressed: _takePicture,
                onLongPress: () {
                  // in case when user pressed cancel on photo access
                },
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.yellow,
                ),
                label: Text(
                  'Take picture',
                  style: TextStyle(color: Colors.yellow[50]),
                ),
              ),
              FlatButton.icon(
                height: 100,
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                label: Text(
                  ' retake',
                  style: TextStyle(color: Colors.yellow[50]),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          //  Save button
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  height: 50,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.blueGrey[900], fontSize: 18),
                  ),
                  color: Colors.yellow[50],
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  onPressed: _saveImage,
                ),
              ),
              FlatButton(
                height: 50,
                child: Text('Back'),
                color: Colors.red[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
