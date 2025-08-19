import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refactoring_firebase_chat/controller/signup_controller.dart';
import 'package:refactoring_firebase_chat/util/const.dart';
import '../controller/login_controller.dart';
import '../util/method.dart';

class LoginFormView extends StatelessWidget {
  LoginFormView(this.controller, {Key? key}) : super(key: key);


  // 정사각형 seb widget, dialog를 위한 width, height size 변수
  late double subWidgetSize;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final smallerSize = deviceWidth > deviceHeight ? deviceHeight : deviceWidth;

    subWidgetSize = smallerSize * WIDGET_SIZE_RATIO;
    // Hive 저장된 기존 데이터 set
    // _getSavedId();

    return Container(
      width: subWidgetSize,
      height: subWidgetSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Email, Password 입력창
          Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                // 아이디 입력폼
                TextFormField(
                  key: const ValueKey(UNIQUE_KEY_BY_LOGIN_ID),
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.idController,
                  validator: (value) {
                    return isValidateTextFormField(UNIQUE_KEY_BY_LOGIN_ID, value);
                  },
                  onSaved: (value) {
                    // controller.userModel().userId = value;
                    controller.setValue(UNIQUE_KEY_BY_LOGIN_ID, value);
                  },
                  onChanged: (value) {
                    // controller.userModel().userId = value;
                    controller.setValue(UNIQUE_KEY_BY_LOGIN_ID, value);
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
                  obscureText: !controller.viewModel().isVisiblePassword,
                  key: const ValueKey(UNIQUE_KEY_BY_LOGIN_PASSWORD),
                  validator: (value) {
                    return isValidateTextFormField(UNIQUE_KEY_BY_LOGIN_PASSWORD, value);
                  },
                  onSaved: (value) {
                    controller.setValue(UNIQUE_KEY_BY_LOGIN_PASSWORD, value);
                  },
                  onChanged: (value) {
                    controller.setValue(UNIQUE_KEY_BY_LOGIN_PASSWORD, value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controller.toggleValue(UNIQUE_KEY_BY_LOGIN_PASSWORD);
                        },
                        child: controller.viewModel().isVisiblePassword
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
                  controller.toggleValue(UNIQUE_KEY_BY_IS_SAVE_ID);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: SIZED_BOX_WIDTH,
                    ),
                    Checkbox(
                      value: controller.viewModel().isSaveId,
                      onChanged: (_) {
                        controller.toggleValue(UNIQUE_KEY_BY_IS_SAVE_ID);
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
                      controller.isAbleLoginProcess();
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
                      _showDialog(UNIQUE_KEY_BY_SIGNUP, context);
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
                      _showDialog(UNIQUE_KEY_BY_FIND_ID_PASSWORD, context);
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

  // 클릭한 버튼에 따라 다이얼로그 표시
  void _showDialog(int flag, BuildContext context) {
    controller.setTargetDialog(flag);
    // 선택한 Dialog 표시
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // child: SignupDialog(),
          child: Container(
            width: subWidgetSize,
            height: subWidgetSize,
            child: controller.targetDialog,
          ),
        );
      },
    );
  }

}
