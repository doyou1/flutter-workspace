import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:refactoring_firebase_chat/controller/login_controller.dart';

import '../util/method.dart';
import '../view/google_login_view.dart';
import 'login_form_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (_) => ModalProgressHUD(
        inAsyncCall: controller.viewModel().isShowSpinner,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            hideKeyboard(context);
          },
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginFormView(controller),
                  GoogleLoginView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
