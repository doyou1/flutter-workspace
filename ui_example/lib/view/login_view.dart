import 'package:flutter/material.dart';

import 'content_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey(1),
                        validator: (value) {
                          if (value != null && value == "testid") {
                            return null;
                          } else {
                            return "Please check id";
                          }
                        },
                        decoration: InputDecoration(
                          label: Text("id: testid"),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: !isVisiblePassword,
                        key: ValueKey(2),
                        validator: (value) {
                          if (value != null && value == "1234") {
                            return null;
                          } else {
                            return "Please check password";
                          }
                        },
                        decoration: InputDecoration(
                          label: Text("password: 1234"),
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisiblePassword = !isVisiblePassword;
                              });
                            },
                            icon: isVisiblePassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // final canLogin = formKey.currentState?.validate() ?? false;
                  // if (canLogin) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const ContentView(),
                  //     ),
                  //   );
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("can not login!"),
                  //     ),
                  //   );
                  // }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContentView(),
                    ),
                  );
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}