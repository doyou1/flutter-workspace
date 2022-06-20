import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refactoring_firebase_chat/controller/login_controller.dart';

import '../model/signup_user_model.dart';
import '../model/signup_view_model.dart';
import '../util/const.dart';

class SignupController extends GetxController {

  BuildContext? context;
  final _authentication = FirebaseAuth.instance;

  final userModel = SignupUserModel().obs;
  final viewModel = SignupViewModel().obs;

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  // Signup process 1
  Future<void> isAbleSignupProcess() async {
    if (isValidateForm()) {
      toggleValue();
      try {
        int? flag = await signupProcess();
        toggleValue();

        if (flag != null) { // 둘다 flag로 처리
          // 회원가입 실패
          showSnackBar(flag);
        }
      } catch (e) {
        toggleValue();
        showSnackBar(UNIQUE_KEY_BY_FAIL_SIGNUP);
      }
    }
  }

  // Signup process 2
  bool isValidateForm() {
    if(userModel().userPickedImage == null) {
      showSnackBar(UNIQUE_KEY_BY_NULL_IMAGE);
      return false;
    }
      var currentState = signupFormKey.currentState;
      final isValid = currentState != null ? currentState.validate() : false;

      if (isValid) {
        currentState.save();
      }

      // 모든 유효성검사 완료시 로그인 처리
      return isValid;
  }

  // Signup process 3
  Future<int?> signupProcess() async {
    try {
      final newUser = await _authentication.createUserWithEmailAndPassword(email: userModel().userId!, password: userModel().userPassword!);

      final refImage = FirebaseStorage.instance.ref().child("picked_image").child("${newUser.user!.uid}.png");
      await refImage.putFile(userModel().userPickedImage!);
      final url = await refImage.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("user")
          .doc(newUser.user!.uid)
          .set({
        "userName": userModel().userName,
        "email": userModel().userId,
        "picked_image": url,
      });

      if (newUser.user != null) { // 회원가입 성공
        viewModel.update((val) {
          if(val != null) {
            val.isShowSpinner = false;
          }
        });

        await saveIdProcess();
        if(context != null) {
          print("context != null");
          Navigator.pop(context!);
        }

        return UNIQUE_KEY_BY_SUCCESS_SIGNUP;
      }
    } catch (e) {
      showSnackBar(UNIQUE_KEY_BY_FAIL_SIGNUP);
      viewModel.update((val) {
        if(val != null) {
          val.isShowSpinner = false;
        }
      });

      return UNIQUE_KEY_BY_FAIL_SIGNUP;
    }
    return UNIQUE_KEY_BY_FAIL_SIGNUP;
  }

  // TextFormField set value
  void setValue(int intFlag, String? value) {
    switch (intFlag) {
      case UNIQUE_KEY_BY_SIGNUP_ID:
        userModel.update((val) {
          if(val != null) {
            val.userId = value;
          }
        });
        break;

      case UNIQUE_KEY_BY_SIGNUP_PASSWORD:
        userModel.update((val) {
          if(val != null) {
            val.userPassword = value;
          }
        });
        break;
    }

  }

  Future<void> saveIdProcess() async {
    var box = await Hive.openBox(SAVE_ID_TEXT);
    box.put(IS_SAVE_ID, true);
    box.put(SAVE_ID_TEXT, userModel().userId);
  }

  // Pick Image in gallery
  void pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );
    if(pickedImageFile != null) {
      userModel.update((val) {
        if(val != null) {
          val.userPickedImage = File(pickedImageFile.path);
        }
      });
    }
  }

  // Show spinner
  void toggleValue() {
    viewModel.update((val) {
      if(val != null) {
        val.isShowSpinner = !val.isShowSpinner;
      }
    });
  }

  // Show snackbar
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

      case UNIQUE_KEY_BY_FAIL_SIGNUP:
        title = SIGNUP_FAIL_NOTI_TITLE;
        text = SIGNUP_FAIL_NOTI_TEXT;
        break;

      case UNIQUE_KEY_BY_SUCCESS_SIGNUP:
        title = SIGNUP_SUCCESS_NOTI_TITLE;
        text = SIGNUP_SUCCESS_NOTI_TEXT;
        break;

      case UNIQUE_KEY_BY_NULL_IMAGE:
        title = SIGNUP_NULL_IMAGE_NOTI_TITLE;
        text = SIGNUP_NULL_IMAGE_NOTI_TEXT;
        break;
    }

    if (title != null && text != null) {
      print("get snackbar");
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