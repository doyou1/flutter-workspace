import 'dart:io';

import 'package:hive/hive.dart';

class HiveUtil {

  static void saveIsSwitched(bool isSwitched) async {
    var path = Directory.current.path;
    Hive
        .init(path);
    var box = await Hive.openBox("Session");
    box.put("isSwitched", isSwitched);
  }

  static Future<bool> getIsSwitched() async {
    var box = await Hive.openBox("Session");
    return box.get("isSwitched") ?? false;
  }

}