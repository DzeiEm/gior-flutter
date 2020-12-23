import 'package:flutter/material.dart';

enum ProcedureType {
  Type1enum,
  Type2enum,
  Type3enum,
  None,
}

const Map<ProcedureType, String> proTypes = {
  ProcedureType.Type1enum: 'Type1',
  ProcedureType.Type2enum: 'Type2',
  ProcedureType.Type3enum: 'Type3',
  ProcedureType.None: 'None',
};

class Procedure {
  final String id;
  final String title;
  final String description;
  final ProcedureType pType;
  final String price;
  final Duration duration;
  final List steps;
  final String imageUrl;

  Procedure(
      {this.id,
      @required this.title,
      @required this.description,
      this.pType,
      this.price,
      this.duration,
      this.steps,
      this.imageUrl});
}
