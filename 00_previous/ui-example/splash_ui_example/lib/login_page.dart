import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          child: Image.asset(
                            "images/logo.png",
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Welcome To Pixel Game!",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Enjoy Our Game!",
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(25.0),
                          margin: EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.deepPurple,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: Text(
                              "JoyStick Game",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(25.0),
                          margin: EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.deepPurple,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: Text(
                              "Accelerometer Game",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "개인정보 보호 및 약관",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "License정보",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.0,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
