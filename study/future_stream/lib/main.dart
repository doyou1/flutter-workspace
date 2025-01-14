import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 0; // used by StreamBuilder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFutureBuilder(),
          SizedBox(height: 24),
          _buildStreamBuilder(),
        ],
      ),
    );
  }

  // constructing FutureBuilder
  Widget _buildFutureBuilder() {
    return Center(
      child: FutureBuilder<int>(
          future: _calculateSquare(10),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              return Text("Square = ${snapshot.data}");
            }
            return CircularProgressIndicator();
          }
      ),
    );
  }

  // used by FutureBuilder
  Future<int> _calculateSquare(int num) async {
    await Future.delayed(Duration(seconds: 5));
    return num * num;
  }

  // constructing StreamBuilder
  Widget _buildStreamBuilder() {
    return Center(
      child: StreamBuilder<int>(
          stream: _stopwatch(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              return Text("Stopwatch = ${snapshot.data}");
            }
            return CircularProgressIndicator();
          }
      ),
    );
  }

  // used by StreamBuilder
  Stream<int> _stopwatch() async* {
    while(true) {
      await Future.delayed(Duration(seconds: 1));
      yield _count++;
    }
  }
}