import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Column Row",
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        // child: Center(
        // child: Column(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center, // 가운데
          // mainAxisSize: MainAxisSize.min, // 가운데
          // verticalDirection: VerticalDirection.down, // bottom

          // mainAxisAlignment: MainAxisAlignment.spaceBetween, // 분할 나눔
          // crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽
          crossAxisAlignment: CrossAxisAlignment.stretch, // 양옆 최대 넓히기
          children: [
            Container(
              // width: 100,
              height: 100,
              color: Colors.white,
              child: Text("Container 1"),
            ),
            SizedBox(
              width: 30.0,
              // height: 30,
            ),
            Container(
              // width: 100,
              height: 100,
              color: Colors.blue,
              child: Text("Container 2"),
            ),
            Container(
              // width: 100,
              height: 100,
              color: Colors.red,
              child: Text("Container 3"),
            ),
            SizedBox(
              width: 30.0,
              // height: 30,
            ),
            Container(
              // width: double.infinity,
              height: 20,
            )
          ],
        ),
        // ),
      ),
    );
  }
}
