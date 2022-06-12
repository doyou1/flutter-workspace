import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          title: Text("Snack Bar"),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext ctx) {
          return Center(
            child: TextButton(
              child: Text(
                "Show me",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                // Scaffold.of(ctx).showSnackBar(SnackBar(content: Text("hello")));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Hell123o"),
                ));
              },
            ),
          );
        }));
  }
}
