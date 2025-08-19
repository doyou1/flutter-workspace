import 'package:flutter/material.dart';
import 'package:how_to_make_flutter_project/hooks/second.dart';
import 'package:provider/provider.dart';


/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Counter with ChangeNotifier {
  BuildContext context;
  int value = 0;
  String text = "hello world";
  Second second = Second();
  Counter(this.context);

  void increment() {
    value += 1;
    notifyListeners();
  }

  String getCurrentData() {
    return "${value}, ${second.secondValue}, ${second.text}";
  }
}