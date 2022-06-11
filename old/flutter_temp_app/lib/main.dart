import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stateful",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int dataToChange = 0;
  void changeData() {
    setState(() {
      dataToChange += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ElevatedButton Demo"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "$dataToChange",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: changeData,
                child: Text("Push the Button!"),
              ),
            ]),
      ),
    );
  }
}
