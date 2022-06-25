import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showWinSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("성공!!!"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  static void showFailSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("실패ㅠㅠㅠ"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent),
    );

    await Future.delayed(const Duration(milliseconds: 1000));
  }

  static void showRequireCountdoenTimerSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Countdown Timer를 시작해주세요!"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey),
    );
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
