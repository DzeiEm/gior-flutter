import 'package:flutter/material.dart';
import 'package:gior/providers/procedures.dart';
import 'package:gior/screens/calendar_screen.dart';
import 'package:provider/provider.dart';

class ProcedureDetailsScreen extends StatelessWidget {
  static const routeName = '/procedure-details-screen';
  @override
  Widget build(BuildContext context) {
    final pickedProcedureIndex =
        ModalRoute.of(context).settings.arguments as String;
    final loadedProcedure = Provider.of<Procedures>(context, listen: false)
        .findById(pickedProcedureIndex);
    var _isAdmin = true;

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blueGrey[900],
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProcedure.title,
                style: TextStyle(color: Colors.blueGrey),
              ),
              background: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.yellow[50],
                  child: Text('image gonna be here'),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                height: 200,
                width: 200,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 100,
                            child: Text(loadedProcedure.description),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            loadedProcedure.price.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            loadedProcedure.duration.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      // SizedBox(height: 150),
                      _isAdmin
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  minWidth: 150,
                                  color: Colors.orangeAccent,
                                  onPressed: () {
                                    // Should be able to edit screen
                                  },
                                  child: Text('edit'),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  minWidth: 150,
                                  color: Colors.red,
                                  child: Text('delete'),
                                  onPressed: () {
                                    Provider.of<Procedures>(context,
                                            listen: false)
                                        .deleteProcedure(loadedProcedure.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            )
                          : FlatButton(
                              color: Colors.purple[200],
                              child: Text(
                                'Book it now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CalendarScreen.routeName);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
