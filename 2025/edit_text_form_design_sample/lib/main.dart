import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _imagePaths = [
    "/Users/simjh/Library/Developer/CoreSimulator/Devices/EA2024A6-6415-4B91-9EE5-49B2C34EB228/data/Containers/Data/Application/826961CF-BAD5-4683-97F2-4272BC457B46/tmp/image_picker_EFC864E5-19CF-4939-A914-5904279C40A8-95568-000004CBA6275897.jpg",
  ];
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSaveButtonVisible = _textController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                SingleChildScrollView(child: _buildImageSection()),
                Expanded(
                  child: _buildTextSection(
                    initialText: _textController.text,
                    onTextChanged: (text) => _textController.text = text,
                    focusNode: _focusNode,
                  ),
                ),
                if (isSaveButtonVisible) _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() => AspectRatio(
    aspectRatio: 1,
    child: PageView.builder(
      itemCount: _imagePaths.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Image.file(File(_imagePaths[index]), fit: BoxFit.contain),
        );
      },
    ),
  );
  Widget _buildTextSection({
    required String initialText,
    required Function(String) onTextChanged,
    required FocusNode focusNode,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return TextInputSheet(
                  initialText: initialText,
                  onTextChanged: onTextChanged,
                  focusNode: focusNode,
                );
              },
            );
          },
        ).then((_) {
          setState(
            () {},
          ); // Refresh the parent widget when bottom sheet is closed
        });
      },
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: _textController.text.isEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.edit, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '느낀 생각을 마음껏 표현해 보세요',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              : Text(
                  _textController.text,
                  style: TextStyle(color: Colors.grey),
                ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: ElevatedButton(
      child: const Text('저장하기'),
      onPressed: () {
        // TODO: save to firestore
        print(_textController.text);
      },
    ),
  );
}

class TextInputSheet extends StatefulWidget {
  const TextInputSheet({
    super.key,
    required this.initialText,
    required this.onTextChanged,
    required this.focusNode,
  });

  final String initialText;
  final ValueChanged<String> onTextChanged;
  final FocusNode focusNode;

  @override
  State<TextInputSheet> createState() => _TextInputSheetState();
}

class _TextInputSheetState extends State<TextInputSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(widget.focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle - fixed at the top
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            // Expandable TextField
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: widget.focusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                cursorWidth: 2.0,
                cursorHeight: 24.0,
                decoration: InputDecoration(
                  hintText: '느낀 생각을 마음껏 표현해 보세요',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  fillColor: Colors.black,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: widget.onTextChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
