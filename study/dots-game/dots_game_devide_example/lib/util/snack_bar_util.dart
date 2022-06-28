import 'package:dots_game_devide_example/util/const.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showWinSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(WIN_SNACK_BAR_TEXT),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueAccent,
      ),
    );
    // await Future.delayed(const Duration(milliseconds: 1000));
  }

  static void showFailSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(FAIL_SNACK_BAR_TEXT),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent),
    );
  }

  static void showRequireCountdownSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(REQUIRE_COUNT_DOWN_SNACK_BAR_TEXT),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey),
    );
  }

  static void showIsSinkHoleSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(IS_SINK_HOLE_SNACK_BAR_TEXT),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red),
    );
  }

  static void showCountDownSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(COUNT_DOWN_SUCCESS_SNACK_BAR_TEXT),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green),
    );
  }

  static void showCountDownFailSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(COUNT_DOWN_FAIL_SNACK_BAR_TEXT),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red),
    );
  }
}
