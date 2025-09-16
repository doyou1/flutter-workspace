import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/core/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/core/models/editor_configs/pro_image_editor_configs.dart';
import 'package:pro_image_editor/features/main_editor/main_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: PhotoSwiperWidget());
  }
}

class PhotoSwiperWidget extends StatefulWidget {
  @override
  _PhotoSwiperWidgetState createState() => _PhotoSwiperWidgetState();
}

class _PhotoSwiperWidgetState extends State<PhotoSwiperWidget> {
  final List<String> images = [];
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;
  bool _isEditing = false;

  // 사진 선택
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        images.add(image.path);
      });
    }
  }

  // 이미지 삭제
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
      if (_currentIndex >= images.length && images.isNotEmpty) {
        _currentIndex = images.length - 1;
      }
    });
  }

  void _editImage(int index) {
    setState(() {
      _isEditing = true;
    });
  }

  void _endEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  // 소스 선택 다이얼로그
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('사진 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('카메라'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('갤러리'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 이미지 swiper
        SizedBox(
          height: 300,
          child: images.isEmpty
              ? GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) =>
                          setState(() => _currentIndex = index),
                      itemBuilder: (context, index) => !_isEditing
                          ? Image.file(File(images[index]), fit: BoxFit.cover)
                          : ProImageEditor.file(
                              File(images[index]),
                              configs: ProImageEditorConfigs(
                                i18n: I18n(

                                )
                                // designMode: ImageEditorDesignMode.values
                              ),
                              callbacks: ProImageEditorCallbacks(
                                onImageEditingComplete: (bytes) async {
                                  await Gal.putImageBytes(
                                    bytes,
                                    name:
                                        "test_${DateTime.now().millisecondsSinceEpoch}",
                                  );
                                  _endEditing();
                                },
                              ),
                            ),
                    ),
                    // 삭제 버튼
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => _removeImage(_currentIndex),
                        child: Icon(Icons.close, color: Colors.white, size: 30),
                      ),
                    ),
                    // 추가 버튼
                    Positioned(
                      top: 10,
                      right: 50,
                      child: GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                    ),
                    // 편집 버튼
                    Positioned(
                      top: 10,
                      right: 90,
                      child: GestureDetector(
                        onTap: () => !_isEditing
                            ? _editImage(_currentIndex)
                            : _endEditing(),
                        child: Icon(Icons.edit, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
        ),
        // 인디케이터
        if (images.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                margin: EdgeInsets.all(4),
                width: _currentIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
