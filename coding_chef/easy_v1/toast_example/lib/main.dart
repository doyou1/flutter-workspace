import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart  ';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Toast Example",
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toast message"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
            child: Text("Toast"),
            onPressed: flutterToast,
            style: TextButton.styleFrom(
              primary: Colors.redAccent,
              backgroundColor: Colors.amber,
            )),
      ),
    );
  }
}

void flutterToast() {
  Fluttertoast.showToast(
    msg: "hello",
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.redAccent,
    fontSize: 20.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG,
  );
}
