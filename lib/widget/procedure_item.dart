import 'package:flutter/material.dart';
import 'package:gior/model/procedure.dart';
import 'package:gior/screens/procedure_details_screen.dart';

class ProcedureItem extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final ProcedureType pType;
  final String price;
  final Duration duration;

  ProcedureItem({
    this.id,
    this.title,
    this.description,
    this.pType,
    this.price,
    this.duration,
  });

  @override
  _ProcedureItemState createState() => _ProcedureItemState();
}

class _ProcedureItemState extends State<ProcedureItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProcedureDetailsScreen.routeName,
              arguments: widget.id);
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            // add image to the procedure
            Card(
              child: Image.asset('assets/images/lem.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Description',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white70),
                          ),
                          Text(
                            widget.description,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white54),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.price.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Eur',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: Colors.orange[200],
            //       child: IconButton(
            //         splashRadius: 3,
            //         color: Colors.blueGrey,
            //         icon: Icon(
            //           Icons.edit,
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             _isEdit = true;
            //             Navigator.of(context).pushNamed(
            //                 AddProcedureScreen.routeName,
            //                 arguments: widget.id);
            //           });
            //         },
            //       ),
            //     ),
            //     SizedBox(width: 20),
            //     CircleAvatar(
            //       backgroundColor: Colors.red[200],
            //       child: IconButton(
            //         splashRadius: 3,
            //         color: Colors.blueGrey,
            //         icon: Icon(
            //           Icons.delete,
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             _isEdit = true;
            //             Navigator.of(context).pushNamed(
            //                 AddProcedureScreen.routeName,
            //                 arguments: widget.id);
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
