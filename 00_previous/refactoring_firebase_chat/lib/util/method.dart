import 'package:flutter/material.dart';
import 'const.dart';

// 특정 TextFormField 유효성검사 및 유효성 실패 알림
// validator in 'TextFormField'
String? isValidateTextFormField(int flag, String? value) {
  switch (flag) {
    case UNIQUE_KEY_BY_LOGIN_ID:
      if (value != null) {
        if (value.isEmpty || !(value.contains("@"))) {
          return ID_FAIL_VALIDATE_NOTI_TEXT;
        } else {
          // 유효성 검사 통과
          return null;
        }
      } else {
        return ID_FAIL_VALIDATE_NOTI_TEXT;
      }
    case UNIQUE_KEY_BY_LOGIN_PASSWORD:
      if (value != null) {
        if (value.isEmpty || value.length < PASSWORD_LENGTH_LIMIT) {
          return PASSWORD_FAIL_VALIDATE_NOTI_TEXT;
        } else {
          // 유효성 검사 통과
          return null;
        }
      } else {
        return PASSWORD_FAIL_VALIDATE_NOTI_TEXT;
      }
    case UNIQUE_KEY_BY_SIGNUP_ID:
      if (value != null) {
        if (value.isEmpty || !(value.contains("@"))) {
          return ID_FAIL_VALIDATE_NOTI_TEXT;
        } else {
          // 유효성 검사 통과
          return null;
        }
      } else {
        return ID_FAIL_VALIDATE_NOTI_TEXT;
      }
    case UNIQUE_KEY_BY_SIGNUP_PASSWORD:
      if (value != null) {
        if (value.isEmpty || value.length < PASSWORD_LENGTH_LIMIT) {
          return PASSWORD_FAIL_VALIDATE_NOTI_TEXT;
        } else {
          // 유효성 검사 통과
          return null;
        }
      } else {
        return PASSWORD_FAIL_VALIDATE_NOTI_TEXT;
      }
  }

  return null;
}

// 입력 중 다른 위젯 클릭시 키보드 비표시
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
