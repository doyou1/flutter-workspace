import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ThumbnailImage extends StatefulWidget {
  const ThumbnailImage({
    super.key,
    required this.image,
    this.isSelected = false,
    this.onTap,
  });

  final AssetEntity image;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<ThumbnailImage> createState() => _ThumbnailImageState();
}

class _ThumbnailImageState extends State<ThumbnailImage> {
  Uint8List? _thumbnailData;
  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final data = await widget.image.thumbnailData;
    if (mounted && data != null) {
      setState(() {
        _thumbnailData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _thumbnailData != null
        ? GestureDetector(
            onTap: widget.onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 썸네일 이미지
                Image.memory(_thumbnailData!, fit: BoxFit.cover),
                // 체크박스
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? Colors.blue
                          : Colors.white.withOpacity(0.7),
                      border: Border.all(
                        color: widget.isSelected ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: widget.isSelected
                        ? Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator(strokeWidth: 2));
  }
}
