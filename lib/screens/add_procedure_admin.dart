import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gior/model/procedure.dart';
import 'package:gior/providers/procedures_pr.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';

class AddProcedureScreen extends StatefulWidget {
  static const routeName = '/add-procedure-admin';

  @override
  _AddProcedureScreenState createState() => _AddProcedureScreenState();
}

class _AddProcedureScreenState extends State<AddProcedureScreen> {
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // tam kad issaugoti forma
  final _descriptionFocusNode = FocusNode();
  ProcedureType _selectedProTypeItem;
  String _selectedPrice;
  Duration _selectedDurationTime = Duration(hours: 0, minutes: 0);
  List<String> listProValues = proTypes.values.toList();
  var _isInit;
  var _isLoading = false;

  var _newProcedure = Procedure(
    id: null,
    title: '',
    description: '',
    pType: null,
    price: '0.0',
    duration: Duration(hours: 2, minutes: 0),
  );

  var _editedProcedure = {
    'title': '',
    'description': '',
    'proType': '',
    'price': '',
    'duration': '',
  };

  @override
  void initState() {
    print('Add procedure screen uploades');
    setState(() {
      _isInit = true;
      print('initState: $_isInit');
    });

    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      print('uploads after init state');

      final procedureID = ModalRoute.of(context).settings.arguments as String;
      if (procedureID != null) {
        _newProcedure = Provider.of<Procedures>(context, listen: false)
            .findById(procedureID);

        _editedProcedure = {
          'id': _newProcedure.id,
          'title': _newProcedure.title,
          'description': _newProcedure.description,
          // 'proType': _newProcedure.pType.toString(),
          // 'price': _newProcedure.price,
          // 'duration': _newProcedure.duration.toString(),
        };
      } else {
        print('procedure id: $procedureID');
        setState(() {
          _isInit = false;
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    textController.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_newProcedure.id != null) {
      await Provider.of<Procedures>(context, listen: false)
          .editProcedure(_newProcedure.id, _newProcedure);
    } else {
      try {
        await Provider.of<Procedures>(context, listen: false)
            .addProcedure(_newProcedure);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Sommething went wrong'),
                  actions: [
                    FlatButton(
                      child: Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
        // } finally {
        //   // sitas blokas runnina nepriklausomai ar buvo erroras koks ar nea
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }

      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void showDurationBottomSheet() {
    Duration initialtimer = Duration();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          color: Colors.blueGrey[900],
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.yellow[50],
            ),
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Set procedure duration time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.blueGrey,
                  ),
                ),
                Divider(
                  height: 30,
                  color: Colors.blueGrey[900],
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: initialtimer,
                    onTimerDurationChanged: (time) {
                      setState(
                        () {
                          print('Selected time: $_selectedDurationTime');
                          _selectedDurationTime = time;
                          // _hours = initialtimer.inHours;
                        },
                      );
                    },
                  ),
                ),
                FlatButton(
                  height: 70,
                  color: Colors.blueGrey[900],
                  child: Text(
                    'Set',
                    style: TextStyle(
                      color: Colors.yellow[50],
                    ),
                  ),
                  onPressed: () {
                    _newProcedure = Procedure(
                        id: _newProcedure.id,
                        title: _newProcedure.title,
                        description: _newProcedure.description,
                        pType: _newProcedure.pType,
                        price: _newProcedure.price,
                        duration: _selectedDurationTime);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPriceBottomSheet() {
    Picker(
        adapter: NumberPickerAdapter(
          data: [
            NumberPickerColumn(begin: 0, end: 100, postfix: Text('€')),
            NumberPickerColumn(begin: 0, end: 99),
          ],
        ),
        delimiter: [
          PickerDelimiter(
            child: Container(
              width: 20,
              child: Text(','),
              alignment: Alignment.center,
            ),
          ),
        ],
        title: Text('Select price'),
        onConfirm: (Picker picker, List value) {
          setState(() {
            print(value.toString());
            print('Picked price: ${picker.getSelectedValues()}');
            _selectedPrice = picker.getSelectedValues().join(',').toString();
            _newProcedure = Procedure(
              id: _newProcedure.id,
              title: _newProcedure.title,
              description: _newProcedure.description,
              pType: _newProcedure.pType,
              price: _selectedPrice,
            );
          });
        }).showModal(context);
  }

  void showProcedureTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          color: Colors.blueGrey[900],
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.yellow[50],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Set Procedure type',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.blueGrey),
                  ),
                  Expanded(
                    // TODO
                    // something wrong here
                    child: CupertinoPicker(
                      diameterRatio: 1,
                      itemExtent: 50,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          _selectedProTypeItem = proTypes.keys.elementAt(index);
                          print('Selected pro type: $_selectedProTypeItem');
                        });
                      },
                      children: [
                        Text(proTypes[ProcedureType.Type1enum]),
                        Text(proTypes[ProcedureType.Type2enum]),
                        Text(proTypes[ProcedureType.Type3enum]),
                        Text(proTypes[ProcedureType.None]),
                      ],
                    ),
                  ),
                  FlatButton(
                    color: Colors.blueGrey[900],
                    height: 70,
                    child: Text(
                      'Set',
                      style: TextStyle(
                        color: Colors.yellow[50],
                      ),
                    ),
                    onPressed: () {
                      _newProcedure = Procedure(
                          description: _newProcedure.description,
                          title: _newProcedure.title,
                          price: _newProcedure.price,
                          duration: _newProcedure.duration,
                          pType: _selectedProTypeItem);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: const Text('Add procedure'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _editedProcedure['title'],
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.yellow[100],
                          style: TextStyle(color: Colors.yellow[100]),
                          decoration: InputDecoration(
                            hintText: 'Procedure title',
                            fillColor: Colors.yellow[50],
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow[50],
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Name cannot be empty';
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          onSaved: (value) {
                            _newProcedure = Procedure(
                                id: _newProcedure.id,
                                title: value,
                                description: _newProcedure.description,
                                pType: _newProcedure.pType,
                                duration: _newProcedure.duration,
                                price: _newProcedure.price);
                          },
                        ),
                        TextFormField(
                          initialValue: _editedProcedure['description'],
                          maxLines: 5,
                          focusNode: _descriptionFocusNode,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.yellow[100]),
                          cursorColor: Colors.yellow[100],
                          decoration: InputDecoration(
                            hintText: 'Description',
                            fillColor: Colors.yellow[50],
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[400],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow[50],
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Description cannot be empty';
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context);
                          },
                          onSaved: (value) {
                            _newProcedure = Procedure(
                                id: _newProcedure.id,
                                title: _newProcedure.title,
                                description: value,
                                pType: _newProcedure.pType,
                                duration: _newProcedure.duration,
                                price: _newProcedure.price);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: InkWell(
                      splashColor: Colors.yellow[50],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.yellow[100],
                                ),
                                Text(
                                  'Type',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _selectedProTypeItem == null
                                ? 'not set'
                                : proTypes[_selectedProTypeItem],
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showProcedureTypeBottomSheet();
                      },
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.yellow[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.money_off_csred_outlined,
                                        color: Colors.yellow[100],
                                      ),
                                      Text(
                                        'Price',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (_selectedPrice == null)
                                          ? '0.0'
                                          : _selectedPrice,
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Eur',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),

                                // Add scrollContenta to pick a price
                              ],
                            ),
                            onTap: () {
                              showPriceBottomSheet();
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.yellow[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lock_clock,
                                        color: Colors.yellow[100],
                                      ),
                                      Text(
                                        'Duration',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _selectedDurationTime == null
                                          ? '0.0'
                                          : _selectedDurationTime.toString(),
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'h',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            onTap: () {
                              showDurationBottomSheet();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: FlatButton(
                      height: 70,
                      color: Colors.yellow[50],
                      splashColor: Colors.teal,
                      child: Text(
                        'Add it',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
