import 'package:flutter/material.dart';
import 'package:refactoring_firebase_chat/util/const.dart';

import 'dialog/find_id_password_dialog.dart';
import 'dialog/signup_dialog.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen(this.loginProcess, {Key? key}) : super(key: key);

  // 해당 화면에서 아이디, 비밀번호 입력 유효성 검사 완료시,
  // LoginScreen(부모 위젯)에서 로그인 처리 진행
  final Function loginProcess;

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  late double subWidgetSize;
  Widget targetWidget = const Center(
    child: Text("empty"),
  );

  // 비밀번호 표시 여부 플래그
  bool isVisiblePassword = false;

  // 아이디 기억 여부 플래그(로그인시 Hive 저장 필요)
  bool isSaveId = false;

  // TextFormField 유효성 검사
  void _validate() {
    var currentState = _loginFormKey.currentState;
    final isValid = currentState != null ? currentState.validate() : false;

    if (isValid) {
      currentState.save();
    }
  }

  void _showDialog(int flag) {
    switch (flag) {
      case UNIQUE_KEY_BY_SIGNUP:
        targetWidget = const SignupDialog();
        break;
      case UNIQUE_KEY_BY_FIND_ID_PASSWORD:
        targetWidget = const FindIdPasswordDialog();
        break;
    }

    // 선택한 Dialog 표시
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.blue,
          // child: SignupDialog(),
          child: Container(
            width: subWidgetSize,
            height: subWidgetSize,
            child: targetWidget,
          ),
        );
      },
    );
  }

  // bool flag 토글
  void toggleBoolFlagValue(int intFlag) {
    setState(() {
      switch (intFlag) {
        case UNIQUE_KEY_BY_PASSWORD:
          isVisiblePassword = !isVisiblePassword;
          break;

        case UNIQUE_KEY_BY_IS_SAVE_ID:
          isSaveId = !isSaveId;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    subWidgetSize = MediaQuery.of(context).size.width * WIDGET_SIZE_RATIO;

    return Container(
      width: subWidgetSize,
      height: subWidgetSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Email, Password 입력창
          Form(
            key: _loginFormKey,
            child: Column(
              children: [
                TextFormField(
                  key: const ValueKey(UNIQUE_KEY_BY_ID),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: ID_TEXT_FORM_FIELD_LABEL,
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: SIZED_BOX_HEIGHT,
                ),
                TextFormField(
                  obscureText: !isVisiblePassword,
                  key: const ValueKey(UNIQUE_KEY_BY_PASSWORD),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          toggleBoolFlagValue(UNIQUE_KEY_BY_PASSWORD);
                        },
                        child: isVisiblePassword
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              )
                            : const Icon(Icons.visibility_off)),
                    labelText: PASSWORD_TEXT_FORM_FIELD_LABEL,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: SIZED_BOX_HEIGHT,
          ),

          // 아이디 저장 checkbox, 로그인 버튼
          Row(
            // 취향입니다.
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Remember me 위젯
              GestureDetector(
                onTap: () {
                  toggleBoolFlagValue(UNIQUE_KEY_BY_IS_SAVE_ID);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: SIZED_BOX_WIDTH,
                    ),
                    Checkbox(
                      value: isSaveId,
                      onChanged: (_) {
                        toggleBoolFlagValue(UNIQUE_KEY_BY_IS_SAVE_ID);
                      },
                    ),
                    const Text(
                      IS_SAVE_ID_TEXT,
                      style: TextStyle(
                        fontSize: FONT_SIZE,
                      ),
                    ),
                  ],
                ),
              ),

              // 로그인 버튼 위젯
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.loginProcess();
                    },
                    child: const Text(
                      LOGIN_TEXT,
                      style: TextStyle(
                        fontSize: FONT_SIZE,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: SIZED_BOX_WIDTH,
                  ),
                ],
              )
            ],
          ),

          const SizedBox(
            height: SIZED_BOX_HEIGHT,
          ),

          // 회원가입 이동 화면, 아이디/비밀번호 찾기
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 회원가입 하이퍼링크
              Row(
                children: [
                  const SizedBox(
                    width: SIZED_BOX_WIDTH,
                  ),
                  InkWell(
                    child: const Text(
                      SIGNUP_TEXT,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: FONT_SIZE,
                      ),
                    ),
                    onTap: () {
                      _showDialog(UNIQUE_KEY_BY_SIGNUP);
                    },
                  ),
                ],
              ),
              // 아이디 비밀번호 찾기
              Row(
                children: [
                  InkWell(
                    child: Text(
                      FIND_ID_PASSWORD_TEXT,
                      style: TextStyle(
                        color: ThemeData().hintColor,
                        fontSize: FONT_SIZE,
                      ),
                    ),
                    onTap: () {
                      _showDialog(UNIQUE_KEY_BY_FIND_ID_PASSWORD);
                    },
                  ),
                  const SizedBox(
                    width: SIZED_BOX_WIDTH,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: SIZED_BOX_HEIGHT,
          ),

        ],
      ),
    );
  }
}
