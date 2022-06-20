import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:refactoring_firebase_chat/model/login_user_model.dart';
import 'package:refactoring_firebase_chat/view/dialog/find_id_password_dialog.dart';

import '../model/login_view_model.dart';
import '../util/const.dart';
import '../view/dialog/signup_dialog.dart';

class LoginController extends GetxController {
  final _authentication = FirebaseAuth.instance;

  final userModel = LoginUserModel().obs;
  final viewModel = LoginViewModel().obs;
  final TextEditingController idController = TextEditingController();

  // isValidateForm, form내의 모든 TextFormField 유효성 검사를 위한 global key
  final loginFormKey = GlobalKey<FormState>();

  // 보여질 Dialog 변수
  Widget targetDialog = const Center(
    child: Text("empty"),
  );

  LoginController() {
    super.onInit();
    getSavedId();
  }

  // 유효성 검사 통과후, 통과한 loginUser 데이터를 통해 로그인 시도
  Future<int?> loginProcess() async {
      // signIn
      await Future.delayed(Duration(seconds: 1,), () {});
      final loginUser = await _authentication.signInWithEmailAndPassword(email: userModel().userId!, password: userModel().userPassword!);

      if(loginUser.user != null) { // 로그인 성공
        await saveIdProcess();
        // return UNIQUE_KEY_BY_SUCCESS_LOGIN;
        return null;
      } else { // 로그인 실패
        return UNIQUE_KEY_BY_FAIL_LOGIN;
      }

  }

  Future<void> saveIdProcess() async {
    var box = await Hive.openBox(SAVE_ID_TEXT);
    box.put(IS_SAVE_ID, viewModel().isSaveId);
    print("isSaveId: ${viewModel().isSaveId}");
    if (viewModel().isSaveId) {
      // 로그인 성공시, id 저장해야 한다면
      box.put(SAVE_ID_TEXT, userModel().userId);
    } else {
      box.put(SAVE_ID_TEXT, null);
    }
  }

  void getSavedId() async {
    var box = await Hive.openBox(SAVE_ID_TEXT);
    String? savedId = box.get(SAVE_ID_TEXT);
    bool? isSaveId = box.get(IS_SAVE_ID);

    print("savedId: $savedId");
    if(isSaveId != null && isSaveId && savedId != null) {
      userModel.update((val) {
        val?.userId = savedId;
        val?.isSaveId = isSaveId;
      });
      idController.text = savedId;
    }

    if(isSaveId != null) {
      viewModel.update((val) {
        val?.isSaveId = isSaveId;
      });
    }

    return;
  }

  // TextFormField 유효성 검사
  // _isAbleLoginProcess 내부 호출 함수 (onTap in 'Signin')
  bool isValidateForm() {
    var currentState = loginFormKey.currentState;
    final isValid = currentState != null ? currentState.validate() : false;

    if (isValid) {
      currentState.save();
    }

    // 모든 유효성검사 완료시 로그인 처리
    return isValid;
  }

  // bool flag 토글
  // onTap 'checkbox', 'password visible button'
  void toggleValue(int intFlag) {
    switch (intFlag) {
      case UNIQUE_KEY_BY_LOGIN_PASSWORD:
        viewModel.update((val) {
          if(val != null) {
            val.isVisiblePassword = !(val.isVisiblePassword);
          }
        });
        break;

      case UNIQUE_KEY_BY_IS_SAVE_ID:
        viewModel.update((val) {
          if(val != null) {
            val.isSaveId = !(val.isSaveId);
          }
        });
        break;
    }
  }

  // TextFormField set value
  void setValue(int intFlag, String? value) {
    switch (intFlag) {
      case UNIQUE_KEY_BY_LOGIN_ID:
        userModel.update((val) {
          if(val != null) {
            val.userId = value;
          }
        });
        break;

      case UNIQUE_KEY_BY_LOGIN_PASSWORD:
        userModel.update((val) {
          if(val != null) {
            val.userPassword = value;
          }
        });
        break;
    }

  }

  // 클릭한 버튼에 따라 다이얼로그 표시
  // onTap in 'Signup', '아이디 비밀번호 찾기'
  void setTargetDialog(int flag) {
    switch (flag) {
      case UNIQUE_KEY_BY_SIGNUP:
        targetDialog = const SignupDialog();
        break;
      case UNIQUE_KEY_BY_FIND_ID_PASSWORD:
        targetDialog = const FindIdPasswordDialog();
        break;
    }
  }

  // onTap in 'Signin'
  Future<void> isAbleLoginProcess() async {
    if (isValidateForm()) {
      viewModel.update((val) {
        val?.isShowSpinner = true;
      });

      try {
        int? flag = await loginProcess();
        viewModel.update((val) {
          val?.isShowSpinner = false;
        });

        if (flag != null) { // 둘다 flag로 처리
          // 로그인 실패
          showSnackBar(flag);
        } else {
          // 로그인 성공
        }
      } catch (e) {
        viewModel.update((val) {
          val?.isShowSpinner = false;
        });
        showSnackBar(UNIQUE_KEY_BY_FAIL_LOGIN);
      }
    }
  }

  void showSnackBar(int flag) {
    String? title;
    String? text;
    switch (flag) {
      case UNIQUE_KEY_BY_FAIL_LOGIN:
        title = LOGIN_FAIL_NOTI_TITLE;
        text = LOGIN_FAIL_NOTI_TEXT;
        break;

      case UNIQUE_KEY_BY_SUCCESS_LOGIN:
        title = LOGIN_SUCCESS_NOTI_TITLE;
        text = LOGIN_SUCCESS_NOTI_TEXT;
        break;
    }

    if (title != null && text != null) {
      Get.snackbar(
        title,
        text,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
  }
}