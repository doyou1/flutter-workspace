import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/util/palette.dart';
import 'package:firebase_chat/views/add_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// 회원가입 및 로그인화면
class LoginSignUpView extends StatefulWidget {
  const LoginSignUpView({Key? key}) : super(key: key);

  @override
  State<LoginSignUpView> createState() => _LoginSignUpViewState();
}

class _LoginSignUpViewState extends State<LoginSignUpView> {
  final _authentication = FirebaseAuth.instance;

  // 회원가입과 로그인 토글 플래글
  bool isSignUpView = true;
  // 로그인 및 회원가입시 await 화면
  bool showSpinner = false;

  // TextFormField validation을 위한 globalkey
  final _formKey = GlobalKey<FormState>();

  // textformfield value를 담는 변수
  String userName = "";
  String userEmail = "";
  String userPassword = "";
  File? userPickedImage;

  // 카메라로부터의 이미지 파일 데이터 담는 함수
  void pickedImage(File image) {
    userPickedImage = image;
  }

  // 전송버튼 클릭시 validation 담당 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  // pick image를 위한 다이얼로그 함수
  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: AddImage(pickedImage),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      // A Widget which should be the the widget to be shown behind the loading barrier
      // 로딩 배리어 뒤에 표시될 위젯이어야 하는 위젯
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              // 윗 배경 위젯
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/orange_background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 90, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Welcome",
                            style: const TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text:
                                isSignUpView ? " to Doyou chat!" : " Back!",
                                style: const TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          isSignUpView
                              ? "Signup to continue"
                              : "Signin to continue",
                          style: const TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 텍스트폼 위젯
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 180,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(20.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  height: isSignUpView ? 280 : 250,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpView = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignUpView
                                          ? Palette.activeColor
                                          : Palette.textColor1,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpView = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "SIGNUP",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: isSignUpView
                                              ? Palette.activeColor
                                              : Palette.textColor1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showAlert(context);
                                        },
                                        child: Icon(
                                          Icons.image,
                                          color: isSignUpView
                                              ? Colors.cyan
                                              : Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 3, 35, 0),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 로그인 화면
                        if (!isSignUpView)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: const ValueKey(1),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty ||
                                            !value.contains("@")) {
                                          return "Please enter a valid email address.";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: "E-mail",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: const ValueKey(2),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "Please enter at least 6 characters";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // 회원가입 화면
                        if (isSignUpView)
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: const ValueKey(3),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty || value.length < 4) {
                                          return "Please enter at least 4 characters";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: "E-mail",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: const ValueKey(4),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty || value.length < 4) {
                                          return "Please enter at least 4 characters";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: "User name",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: const ValueKey(5),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty || value.length < 6) {
                                          return "Please enter at least 6 characters";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Palette.textColor1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // 전송버튼
              AnimatedPositioned(
                top: isSignUpView ? 430 : 390,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        print("userPickedImage: $userPickedImage");
                        if (userPickedImage == null) {
                          showSpinner = false;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please pick you image"),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          return;
                        }

                        _tryValidation();
                        if (isSignUpView) {
                          // 회원가입
                          try {
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            final refImage = FirebaseStorage.instance
                                .ref()
                                .child("picked_image")
                                .child(newUser.user!.uid + ".png");

                            await refImage.putFile(userPickedImage!);

                            final url = await refImage.getDownloadURL();

                            await FirebaseFirestore.instance
                                .collection("user")
                                .doc(newUser.user!.uid)
                                .set({
                              "userName": userName,
                              "email": userEmail,
                              "picked_image": url,
                            });

                            if (newUser.user != null) {
                              if (!mounted) return;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return const ChatView();
                              //     },
                              //   ),
                              // );
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            print("exception: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please check your email and password"),
                                backgroundColor: Colors.blue,
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else {
                          try {
                            final loginUser = await _authentication
                                .signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            if (loginUser.user != null) {
                              if (!mounted) return;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return const ChatView();
                              //     },
                              //   ),
                              // );
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            print("exception: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please check your email and password"),
                                backgroundColor: Colors.blue,
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 구글 로그인 버튼
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignUpView
                    ? MediaQuery
                    .of(context)
                    .size
                    .height - 125
                    : MediaQuery
                    .of(context)
                    .size
                    .height - 165,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignUpView ? "or Signup with" : "or Signin with"),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(155, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Palette.googleColor,
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text("Google"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
