import 'package:flutter/material.dart';
import 'package:gior/providers/procedures_pr.dart';
import 'package:gior/screens/add_procedure_admin.dart';
import 'package:gior/widget/procedure_list.dart';
import 'package:provider/provider.dart';

class ProcedureListScreen extends StatefulWidget {
  static const routeName = 'procedure-screen';

  @override
  _ProcedureListScreenState createState() => _ProcedureListScreenState();
}

class _ProcedureListScreenState extends State<ProcedureListScreen> {
  var _isInit = true;
  var _isLoding = true;

  @override
  void initState() {
    print('init state procedure list');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('did change dep');
    if (_isInit) {
      setState(() {
        _isLoding = true;
      });

      Provider.of<Procedures>(context, listen: false)
          .fetchAndSetProceduresData()
          .then((_) {
        setState(() {
          _isLoding = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> _refreshProcedures() async {
    await Provider.of<Procedures>(context, listen: false)
        .fetchAndSetProceduresData();
  }

  @override
  Widget build(BuildContext context) {
    print('----------PROCEDURE LIST SCREEN-----------');
    final procedures = Provider.of<Procedures>(context);
    final prodList = procedures.procedures;
    var ifAdmin = true;

    void _filterByManicure() {
      // manicure procedures
    }
    void _filterByPedicure() {
      // pedicure procedures
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clean_hands),
            onPressed: _filterByManicure,
            splashColor: Colors.yellowAccent[100],
          ),
          IconButton(
            icon: Icon(Icons.sports_football),
            onPressed: _filterByPedicure,
            splashColor: Colors.yellowAccent[100],
          ),
        ],
        backgroundColor: Colors.blueGrey[800],
        elevation: 5,
        centerTitle: false,
        title: Text(
          'Procedures',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 2, right: 2),
          child: ifAdmin && prodList.length == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No procedures yet',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Add it :)',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          color: Colors.white12,
                          child: Text(
                            'Add procedure',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddProcedureScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : _isLoding
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.yellow,
                        ),
                        value: 20,
                        strokeWidth: 15,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshProcedures,
                      child: Column(
                        children: [
                          ProcedureList(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                color: Colors.white12,
                                child: Text(
                                  'Add procedure',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AddProcedureScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
