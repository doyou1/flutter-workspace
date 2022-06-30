import 'package:custom_painter_sampling/paint_page/arc_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/circle_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/game_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/image_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/line_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/rectangle_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/rounded_rectangle_paint_page.dart';
import 'package:custom_painter_sampling/paint_page/triangle_paint_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("CustomPainter Sampling"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.line_weight), text: "Line"),
              Tab(icon: Icon(Icons.square_outlined), text: "Rectangle"),
              Tab(icon: Icon(Icons.crop_square), text: "Rounded Rectangle"),
              Tab(icon: Icon(Icons.circle_outlined), text: "Circle"),
              Tab(icon: Icon(Icons.architecture), text: "Arc"),
              Tab(icon: Icon(Icons.change_history), text: "Triangle"),
              Tab(icon: Icon(Icons.image), text: "Image"),
              Tab(icon: Icon(Icons.gamepad_outlined), text: "Game"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LinePaintPage(),
            RectanglePaintPage(),
            RoundedRectanglePaintPage(),
            CirclePaintPage(),
            ArcPaintPage(),
            TrianglePaintPage(),
            ImagePaintPage(),
            GamePaintPage(),
          ],
        ),
      ),
    );
  }
}
