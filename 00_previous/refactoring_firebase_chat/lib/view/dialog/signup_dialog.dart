import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/signup_controller.dart';
import '../../util/const.dart';
import '../../util/method.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({Key? key}) : super(key: key);

  @override
  State<SignupDialog> createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  final SignupController controller = Get.put(SignupController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SignupController>(
      builder: (_) => ModalProgressHUD(
          inAsyncCall: controller.viewModel().isVisiblePassword,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              hideKeyboard(context);
            },
            child: Container(
              margin: EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 타이틀
                    Text(
                      SIGNUP_TEXT,
                      style: TextStyle(
                        fontSize: BIG_FONT_SIZE,
                      ),
                    ),

                    SizedBox(
                      height: SIZED_BOX_HEIGHT,
                    ),

                    Form(
                      key: controller.signupFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 아이디 입력폼
                          TextFormField(
                            key: const ValueKey(UNIQUE_KEY_BY_SIGNUP_ID),
                            controller: controller.idController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              return isValidateTextFormField(
                                  UNIQUE_KEY_BY_SIGNUP_ID, value);
                            },
                            onSaved: (value) {
                              controller.setValue(
                                  UNIQUE_KEY_BY_SIGNUP_ID, value);
                            },
                            onChanged: (value) {
                              controller.setValue(
                                  UNIQUE_KEY_BY_SIGNUP_ID, value);
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: ID_TEXT_FORM_FIELD_LABEL,
                                border: OutlineInputBorder()),
                          ),

                          SizedBox(
                            height: SIZED_BOX_HEIGHT,
                          ),

                          // 비밀번호 입력폼
                          TextFormField(
                            // 비밀번호 암호화(********)
                            obscureText:
                                !controller.viewModel().isVisiblePassword,
                            key: const ValueKey(UNIQUE_KEY_BY_SIGNUP_PASSWORD),
                            controller: controller.passwordController,
                            validator: (value) {
                              return isValidateTextFormField(
                                  UNIQUE_KEY_BY_SIGNUP_PASSWORD, value);
                            },
                            onSaved: (value) {
                              controller.setValue(
                                  UNIQUE_KEY_BY_SIGNUP_PASSWORD, value);
                            },
                            onChanged: (value) {
                              controller.setValue(
                                  UNIQUE_KEY_BY_SIGNUP_PASSWORD, value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.toggleValue();
                                  },
                                  child:
                                      controller.viewModel().isVisiblePassword
                                          ? const Icon(
                                              Icons.visibility,
                                              color: Colors.blue,
                                            )
                                          : const Icon(Icons.visibility_off)),
                              labelText: PASSWORD_TEXT_FORM_FIELD_LABEL,
                              border: const OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(
                            height: SIZED_BOX_HEIGHT,
                          ),

                          // 이미지 추가 입력폼
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage: controller
                                            .userModel()
                                            .userPickedImage !=
                                        null
                                    ? FileImage(
                                        controller.userModel().userPickedImage!)
                                    : null,
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  controller.pickImage();
                                },
                                icon: const Icon(Icons.image),
                                label: const Text("Add icon"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: SIZED_BOX_HEIGHT,
                    ),

                    // 로그인 버튼 위젯
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.isAbleSignupProcess();
                          },
                          child: const Text(
                            SIGNUP_TEXT,
                            style: TextStyle(
                              fontSize: FONT_SIZE,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
