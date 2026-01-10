import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accordion Sampling')),
      body: Center(
        child: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text('모든 이에게 웃음 아무도 그를 기억하지 못했...'),
                trailing: Icon(Icons.keyboard_arrow_down),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('여기에 확장될 내용을 넣으세요'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
