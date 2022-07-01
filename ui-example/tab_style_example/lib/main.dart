import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              // 비활성화 탭 라벨 텍스트 색
              unselectedLabelColor: Colors.deepPurple[200],
              // 활성화 탭 관련 설정
              // indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                color: Colors.deepPurple[300],
              ),
              tabs: [
                // Tab(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       // borderRadius: BorderRadius.circular(20.0),
                //       borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                //     ),
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: Text("APPS"),
                //     ),
                //   ),
                // ),
                Tab(text: "APPS"),
                Tab(text: "MOVIES"),
                Tab(text: "GAMES"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.apps),
              Icon(Icons.movie),
              Icon(Icons.games),
            ],
          ),
        ),
      ),
    );
  }
}
