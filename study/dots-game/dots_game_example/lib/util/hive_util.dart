import 'dart:io';

import 'package:dots_game_example/util/const.dart';
import 'package:hive/hive.dart';

class HiveUtil {
  static void saveIsSwitched(bool isSwitched) async {
    var box = await Hive.openBox("Session");
    box.put("isSwitched", isSwitched);
  }

  static void saveIsRunning(bool isRunning) async {
    var box = await Hive.openBox("Timer");
    box.put("isRunning", isRunning);
  }

  static void saveSecond(int second) async {
    var box = await Hive.openBox("Timer");
    box.put("second", second);
  }

  static void saveGameCount(int gameCount) async {
    var box = await Hive.openBox("Timer");
    box.put("gameCount", gameCount);
  }

  static Future<bool> getIsSwitched() async {
    var box = await Hive.openBox("Session");
    return box.get("isSwitched") ?? false;
  }

  static Future<bool> getIsRunning() async {
    final box = await Hive.openBox("Timer");
    return box.get("isRunning") ?? false;
  }

  static Future<int> getSecond() async {
    final box = await Hive.openBox("Timer");
    return box.get("second") ?? SECOND;
  }

  static Future<int> getGameCount() async {
    final box = await Hive.openBox("Timer");
    return box.get("gameCount") ?? GAME_COUNT;
  }
}
