import 'package:flutter/material.dart';
import 'package:gior/providers/events_pr.dart';
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
              _buildUpperContainer(context),
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

Widget _buildUpperContainer(BuildContext context) {
  return Container(
    height: 180,
    margin: EdgeInsets.only(top: 70, left: 10, right: 10),
    child: Row(
      children: [
        Expanded(
          child: Stack(
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
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: 170,
                        height: 170,
                        color: Colors.amber.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: FloatingActionButton(
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.yellow,
                          elevation: 6,
                          onPressed: () {
                            // add immage
                          }),
                    ),
                  ],
                ),
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
