import 'package:flutter/cupertino.dart';
import 'package:gior/model/event.dart';

class Events with ChangeNotifier {
  List<Event> _plans = [];
  List<Event> get plans {
    return [..._plans];
  }

  void cancelVisit() {
    notifyListeners();
  }

  void changeEventDay() {
    notifyListeners();
  }
}
