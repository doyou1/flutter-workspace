import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late Object model;
  late Object _dice;
  late Scene _scene;

  @override
  void initState() {
    // model = Object(fileName: "assets/model.obj");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Flutter 3D"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  _scene = scene;
                  _dice = Object(fileName: "assets/model.obj");
                  scene.world.add(_dice);
                  // scene.camera.zoom = 10.0;
                },
              ),
            ),
            ElevatedButton(
              child: Text("Roll"),
              onPressed: () {
                _dice.rotation.x = Random().nextDouble() * 360.0;
                _dice.rotation.y = Random().nextDouble() * 360.0;
                _dice.rotation.z = Random().nextDouble() * 360.0;
                _dice.updateTransform();
                _scene.update();
                },
            ),
          ],
        ),
      ),
    );
  }
}
