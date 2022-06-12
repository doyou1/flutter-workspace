import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Buttons",
      home: const MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buttons"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                print("text button");
              },
              onLongPress: () {
                print("long pressed");
              },
              child: Text(
                "Text button",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.red,
                // backgroundColor: Colors.blue,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("Elevated Button");
              },
              child: Text("Eleavted button"),
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                elevation: 0.0,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                print("Outlined button");
              },
              child: Text("Outlined button"),
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.red,
                side: BorderSide(
                  color: Colors.black87,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                print("Icon button");
              },
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.black87, // 설정하지 않으면 primary에 따름
              ),
              label: Text("Go to home"),
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print("ElevatedButton Icon");
              },
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.black87, // 설정하지 않으면 primary에 따름
              ),
              label: Text("Go to home"),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                print("ElevatedButton Icon");
              },
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.black87, // 설정하지 않으면 primary에 따름
              ),
              label: Text("Go to home"),
              style: OutlinedButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              label: Text("UnActivate Icon"),
              style: ElevatedButton.styleFrom(
                onSurface: Colors.pink,
              ),
            ),
            ButtonBar(
              // default는 right 정렬
              alignment: MainAxisAlignment.center,
              buttonPadding: EdgeInsets.all(20),
              children: [
                ElevatedButton(
                  onPressed: null,
                  child: Text("Buttonbar 1"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Buttonbar 2"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
