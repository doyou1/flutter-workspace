import 'package:custom_painter_example/view/arc_paint_page.dart';
import 'package:custom_painter_example/view/circle_paint_page.dart';
import 'package:custom_painter_example/view/image_paint_page.dart';
import 'package:custom_painter_example/view/line_paint_page.dart';
import 'package:custom_painter_example/view/rectangle_paint_page.dart';
import 'package:custom_painter_example/view/rounded_rectangle_paint_page.dart';
import 'package:custom_painter_example/view/triangle_paint_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final String title = "CustomPainter Example";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.stacked_line_chart), text: "Line"),
              Tab(icon: Icon(Icons.crop_landscape), text: "Rectangle"),
              Tab(icon: Icon(Icons.crop_square), text: "Rounded Rectangle"),
              Tab(icon: Icon(Icons.circle), text: "Circle"),
              Tab(icon: Icon(Icons.architecture), text: "Arc"),
              Tab(icon: Icon(Icons.warning), text: "Trinagle"),
              Tab(icon: Icon(Icons.image), text: "Image"),
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
          ],
        ),
      ),
    );
  }
}
