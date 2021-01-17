import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gior/providers/events_pr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Column(
            children: [
              BuildUpperContainer(),
              SizedBox(
                height: 100,
                child: Card(
                  color: Colors.blueGrey[900],
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  elevation: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'My plans ',
                        style: TextStyle(fontSize: 20, color: Colors.white60),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              BuildMyOrders(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildUpperContainer extends StatefulWidget {
  @override
  _BuildUpperContainerState createState() => _BuildUpperContainerState();
}

class _BuildUpperContainerState extends State<BuildUpperContainer> {
  File _image;
  
  void _takePictureFrom(BuildContext context) {
    const List<String> options = ['gallery', 'camera'];
    showBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: 90,
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              child: FlatButton(
                height: 60,
                color: Colors.teal.withOpacity(0.6),
                child: Text(options[0],
                    style: TextStyle(color: Colors.yellow[50])),
                onPressed: () {
                  print('WAS PICKED: ${options[0]}');
                  return _getImage(0);
                },
              ),
            )),
            SizedBox(width: 5),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: FlatButton(
                  height: 60,
                  color: Colors.teal.withOpacity(0.6),
                  child: Text(
                    options[1],
                    style: TextStyle(color: Colors.yellow[50]),
                  ),
                  onPressed: () {
                    print('WWAS PICKED ${options[1]}');
                    return _getImage(1);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage(int option) async {
    final picker = ImagePicker();

    final image = await picker.getImage(
        source: (option == 0) ? ImageSource.gallery : ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _image = File(image.path);
    });
    final appDir = getApplicationDocumentsDirectory();
    final fileName = basename(image.path);
    // final savedImage = await _image.copy('${appDir.path}/$fileName');  
    // _selectImage(savedImage);

  }
  void _selectImage(File image){
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.only(top: 70, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[400].withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: _image == null
                        ? Container(
                            color: Colors.yellow[50].withOpacity(0.2),
                            child: Icon(
                              Icons.mood,
                              size: 100,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              height: 150,
                              width: 170,
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.yellow,
                      elevation: 6,
                      splashColor: Colors.purple,
                      onPressed: () {
                        // _takePictureFrom(context);
                        print('get image tapped');
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal[400].withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.amberAccent,
                          alignment: Alignment.center,
                          child: Text('TIME DISPLAY'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.phone_iphone,
                            color: Colors.blueGrey[50],
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.messenger,
                            color: Colors.blueGrey[50],
                          ),
                          onPressed: () {}),
                      IconButton(
                        icon: Icon(Icons.done_all, color: Colors.blueGrey[50]),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildMyOrders extends StatelessWidget {
  final bool isPlanned = false;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Events>(context);
    final plans = data.plans;

    return Expanded(
      child: isPlanned
          ? ListView.builder(
              itemCount: plans.length,
              itemBuilder: (ctx, index) => _buildPlannedContainer(
                plans[index].description,
                plans[index].pType,
                plans[index].price,
              ),
            )
          : _buildEmptyPlansContainer(),
    );
  }
}

_buildPlannedContainer(String pType, String date, double price) {
  return ListTile(
    title: Text(pType),
    subtitle: Text(date),
    trailing: Text(price.toString()),
  );
}

_buildEmptyPlansContainer() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    child: Stack(
      children: [
        Container(
          color: Colors.yellow[50],
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10, top: 30),
          alignment: Alignment.topCenter,
          child: Text(
            'Oooops, no plans for now',
            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: FlatButton(
              minWidth: 200,
              onPressed: () {},
              child: Text(
                'Add it',
                style: TextStyle(color: Colors.yellow[50]),
              ),
              color: Colors.teal,
            ),
          ),
        ),
      ],
    ),
  );
}
