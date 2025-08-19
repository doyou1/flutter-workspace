import 'package:flutter/material.dart';


/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Second {
  String text = "second";
  int secondValue = -1;

  void increaseSecondValue() {
    secondValue++;
  }
}