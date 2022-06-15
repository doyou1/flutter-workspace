import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(
  new MaterialApp(
    home: PositionedTile(),
  ),
);

class PositionedTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTileState();
}

class PositionedTileState extends State<PositionedTile> {
  List<Widget> tiles = [
    // StatefulColorfulTile(key: UniqueKey(),),
    // StatefulColorfulTile(key: UniqueKey(),),
    StatefulColorfulTile(),
    StatefulColorfulTile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tiles,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.double_arrow_rounded),
          onPressed: (){
            swapTiles();
            flutterToast();
          }
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefulColorfulTile extends StatefulWidget {
  // const StatefulColorfulTile({required Key key}) : super(key: key);
  @override
  _StatefulColorfulTileState createState() => _StatefulColorfulTileState();
}

class _StatefulColorfulTileState extends State<StatefulColorfulTile> {
  Color myColor = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}

getRandomColor() {
  var r = Random();
  return Color.fromARGB(255, r.nextInt(255), r.nextInt(255), r.nextInt(255));
}

void flutterToast() {
  Fluttertoast.showToast(
      msg: 'Color has been changed',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT
  );
}