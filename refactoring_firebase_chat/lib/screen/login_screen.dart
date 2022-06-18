import 'package:flutter/material.dart';
import 'package:refactoring_firebase_chat/vo/login_user_vo.dart';

import 'google_login_screen.dart';
import 'login_form_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // 유효성 검사 통과후, 통과한 loginUser 데이터를 통해 로그인 시도
  void loginProcess(LoginUserVo loginUser) {
    // print("loginUser: ${loginUser.userId}");
    // print("loginUser: ${loginUser.userPassword}");
    // print("loginUser: ${loginUser.isSaveId}");
  }

  // 입력 중 다른 위젯 클릭시 키보드 비표시
  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        hideKeyboard();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginFormScreen(loginProcess),
            GoogleLoginScreen(),
          ],
        ),
      ),
    );
  }
}
