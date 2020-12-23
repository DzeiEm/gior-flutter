import 'package:flutter/material.dart';
import 'package:gior/providers/events.dart';
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
                child: Text(
                  'Image gonna be',
                  style: TextStyle(color: Colors.white70),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ),
      ],
    ),
  );
}

class BuildMyOrders extends StatelessWidget {
  bool isPlanned = false;

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
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: ListTile(
      title: Text(pType),
      subtitle: Text('Visit time: $date'),
      trailing: Chip(
        backgroundColor: Colors.green,
        label: Text((price).toString()),
      ),
    ),
  );
}

_buildEmptyPlansContainer() {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    color: Colors.yellow[100],
    child: Center(
      child: Text(
        ' Oooops, no plans for now',
        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
      ),
    ),
  );
}
