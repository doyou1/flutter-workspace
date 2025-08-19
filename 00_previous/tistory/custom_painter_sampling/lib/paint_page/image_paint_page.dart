import 'package:custom_painter_sampling/painter/image_painter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ImagePaintPage extends StatefulWidget {
  const ImagePaintPage({Key? key}) : super(key: key);

  @override
  State<ImagePaintPage> createState() => _ImagePaintPageState();
}

class _ImagePaintPageState extends State<ImagePaintPage> {
  ui.Image? image;


  @override
  void initState() {
    super.initState();

    loadImage("assets/image.jpg");
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    setState(() => this.image = image);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image == null
          ? CircularProgressIndicator()
          : Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: FittedBox(
          child: SizedBox(
            width: image!.width.toDouble(),
            height: image!.height.toDouble(),
            child: CustomPaint(
              painter: ImagePainter(image!),
            ),
          ),
        ),
      ),
    );
  }
}