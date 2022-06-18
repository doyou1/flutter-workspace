import 'package:flutter/material.dart';
import 'package:refactoring_firebase_chat/util/const.dart';
import 'package:refactoring_firebase_chat/vo/login_user_vo.dart';

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

  LoginUserVo loginUser = LoginUserVo();

  // _isValidateForm, form내의 모든 TextFormField 유효성 검사를 위한 global key
  final _loginFormKey = GlobalKey<FormState>();
  // 정사각형 seb widget, dialog를 위한 width, height size 변수
  late double subWidgetSize;
  // 보여질 Dialog 변수
  Widget targetDialog = const Center(
    child: Text("empty"),
  );
  // 비밀번호 표시 여부 플래그
  bool isVisiblePassword = false;
  // 아이디 기억 여부 플래그(로그인시 Hive 저장 필요)
  bool isSaveId = false;

  // onChanged, onSaved in 'TextFormField'
  void _setValue(int flag, String? value) {
    switch (flag) {
      case UNIQUE_KEY_BY_ID:
        loginUser.userId = value;
        break;
      case UNIQUE_KEY_BY_PASSWORD:
        loginUser.userPassword = value;
        break;
    }
  }

  // 클릭한 버튼에 따라 다이얼로그 표시
  // onTap in 'Signup', '아이디 비밀번호 찾기'
  void _showDialog(int flag) {
    switch (flag) {
      case UNIQUE_KEY_BY_SIGNUP:
        targetDialog = const SignupDialog();
        break;
      case UNIQUE_KEY_BY_FIND_ID_PASSWORD:
        targetDialog = const FindIdPasswordDialog();
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
            child: targetDialog,
          ),
        );
      },
    );
  }

  // bool flag 토글
  // onTap 'checkbox', 'password visible button'
  void _toggleBoolFlagValue(int intFlag) {
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

  // onTap in 'Signin'
  void _isAbleLoginProcess() {
    if(_isValidateForm()) {
      loginUser.isSaveId = isSaveId;
      widget.loginProcess(loginUser);
    }
  }

  // TextFormField 유효성 검사
  // _isAbleLoginProcess 내부 호출 함수 (onTap in 'Signin')
  bool _isValidateForm() {
    var currentState = _loginFormKey.currentState;
    final isValid = currentState != null ? currentState.validate() : false;

    if (isValid) {
      currentState.save();
    }

    // 모든 유효성검사 완료시 로그인 처리
    return isValid;
  }

  // 특정 TextFormField 유효성검사 및 유효성 실패 알림
  // validator in 'TextFormField'
  String? _isValidateTextFormField(int flag, String? value) {
    if (value != null) {
      switch (flag) {
        case UNIQUE_KEY_BY_ID:
          if (value.isEmpty || !value.contains("@")) {
            return ID_FAIL_VALIDATE_NOTI_TEXT;
          }
          break;
        case UNIQUE_KEY_BY_PASSWORD:
          if (value.isEmpty || value.length < PASSWORD_LENGTH_LIMIT) {
            return PASSWORD_FAIL_VALIDATE_NOTI_TEXT;
          }
          break;
      }
    }
    return null;
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
                // 아이디 입력폼
                TextFormField(
                  key: const ValueKey(UNIQUE_KEY_BY_ID),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return _isValidateTextFormField(UNIQUE_KEY_BY_ID, value);
                  },
                  onSaved: (value) {
                    _setValue(UNIQUE_KEY_BY_ID, value);
                  },
                  onChanged: (value) {
                    _setValue(UNIQUE_KEY_BY_ID, value);
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: ID_TEXT_FORM_FIELD_LABEL,
                      border: OutlineInputBorder()),
                ),

                const SizedBox(
                  height: SIZED_BOX_HEIGHT,
                ),

                // 비밀번호 입력폼
                TextFormField(
                  // 비밀번호 암호화(********)
                  obscureText: !isVisiblePassword,
                  key: const ValueKey(UNIQUE_KEY_BY_PASSWORD),
                  validator: (value) {
                    return _isValidateTextFormField(UNIQUE_KEY_BY_PASSWORD, value);
                  },
                  onSaved: (value) {
                    _setValue(UNIQUE_KEY_BY_PASSWORD, value);
                  },
                  onChanged: (value) {
                    _setValue(UNIQUE_KEY_BY_PASSWORD, value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          _toggleBoolFlagValue(UNIQUE_KEY_BY_PASSWORD);
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
                  _toggleBoolFlagValue(UNIQUE_KEY_BY_IS_SAVE_ID);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: SIZED_BOX_WIDTH,
                    ),
                    Checkbox(
                      value: isSaveId,
                      onChanged: (_) {
                        _toggleBoolFlagValue(UNIQUE_KEY_BY_IS_SAVE_ID);
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
                    onPressed: _isAbleLoginProcess,
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
