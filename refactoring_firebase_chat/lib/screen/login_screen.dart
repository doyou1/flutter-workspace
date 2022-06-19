import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:refactoring_firebase_chat/util/const.dart';
import 'package:refactoring_firebase_chat/util/show_snack_bar.dart';
import 'package:refactoring_firebase_chat/vo/login_user_vo.dart';

import 'google_login_screen.dart';
import 'login_form_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 로그인 처리시 로딩 위젯
  bool isShowSpinner = false;

  // 유효성 검사 통과후, 통과한 loginUser 데이터를 통해 로그인 시도
  void loginProcess(LoginUserVo loginUser) async {
    // Show Spinner!
    setState(() {
      isShowSpinner = true;
    });

    try {
      final result = await fackSignIn(
          email: loginUser.userId, password: loginUser.userPassword);


      if (result != null) {
        // 로그인 성공
        await saveIdProcess(loginUser.isSaveId, loginUser.userId);

        moveToMainScreen();
      } else {
        // 로그인 실패
        if (!mounted) return;
        showSnackBar(context, UNIQUE_KEY_BY_FAIL_LOGIN);
      }
    } catch (e) {
      showSnackBar(context, UNIQUE_KEY_BY_FAIL_LOGIN);

      // Hide Spinner!
      setState(() {
        isShowSpinner = false;
      });
    }
    // Hide Spinner!
    setState(() {
      isShowSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isShowSpinner,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: hideKeyboard,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginFormScreen(loginProcess),
              GoogleLoginScreen(),
            ],
          ),
        ),
      ),
    );
  }

  // SignIn 처리
  Future<LoginUserVo?> fackSignIn(
      {required String? email, required String? password}) async {
    await Future.delayed(Duration(seconds: 3), () {});

    return LoginUserVo()
      ..userId = email
      ..userPassword = password;
    // return null;
  }

  Future<void> saveIdProcess(bool? isSaveId, String? userId) async {
    var box = await Hive.openBox(SAVE_ID_TEXT);

    box.put(IS_SAVE_ID, isSaveId);
    if (isSaveId!) {
      // 로그인 성공시, id 저장해야 한다면
      box.put(SAVE_ID_TEXT, userId);
    } else {
      box.put(SAVE_ID_TEXT, null);
    }
  }

  // Move to MainScreen
  void moveToMainScreen() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("move to main screen"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // 입력 중 다른 위젯 클릭시 키보드 비표시
  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
