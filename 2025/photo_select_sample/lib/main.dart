import 'package:flutter/material.dart';
import 'package:photo_select_sample/photo_select_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SelectedImage> _images = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openPhotoSelectDialog();
    });
  }

  Future<void> _openPhotoSelectDialog() async {
    final maxCount = MAX_COUNT - _images.length;
    final result = await showDialog(
      context: context,
      builder: (_) {
        return PhotoSelectDialog(maxCount: maxCount);
      },
    );
    if (result != null) {
      final r = result as List<SelectedImage>;
      setState(() {
        _images.addAll(r);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {
              _openPhotoSelectDialog();
            },
            child: Text("선택"),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_images.isNotEmpty)
            Expanded(
              child: PageView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final image = _images[index];
                  return Image.memory(image.originBytes, fit: BoxFit.cover);
                },
              ),
            ),
        ],
      ),
    );
  }
}
