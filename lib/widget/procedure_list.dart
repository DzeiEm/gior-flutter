import 'package:flutter/material.dart';
import 'package:gior/providers/procedures_pr.dart';
import 'package:gior/widget/procedure_item.dart';
import 'package:provider/provider.dart';

class ProcedureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proceduresData = Provider.of<Procedures>(context);
    final procedureList = proceduresData.procedures;

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            ProcedureItem(
              procedureList[index].id,
              procedureList[index].title,
              procedureList[index].description,
              procedureList[index].pType,
              procedureList[index].price,
              procedureList[index].duration,
            ),
          ],
        ),
        itemCount: procedureList.length,
      ),
    );
  }
}
