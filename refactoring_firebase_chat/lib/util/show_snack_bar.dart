import 'package:flutter/material.dart';

import 'const.dart';

void showSnackBar(BuildContext context, int flag) {
  String? text;
  switch (flag) {
    case UNIQUE_KEY_BY_FAIL_LOGIN:
      text = LOGIN_FAIL_NOTI_TEXT;
  }

  if (text != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
