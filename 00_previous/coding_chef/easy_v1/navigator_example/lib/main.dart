import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Example',
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext firstPageCtx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to the Second Page"),
          onPressed: () {
            Navigator.push(
              firstPageCtx,
              MaterialPageRoute(
                // builder: (BuildContext context) {
                //   return SecondPage();
                // },
                // builder: (context) => SecondPage(),
                builder: (_) => SecondPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext secondPageCtx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to the First Page"),
          onPressed: () {
            Navigator.pop(secondPageCtx);
          },
        ),
      ),
    );
  }
}
