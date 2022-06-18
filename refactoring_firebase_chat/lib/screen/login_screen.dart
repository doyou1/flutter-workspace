import 'package:flutter/material.dart';

import 'google_login_screen.dart';
import 'login_form_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // 유효성 검사 통과후, 로그인 처리
  void loginProcess() {
    print("로그인");
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
