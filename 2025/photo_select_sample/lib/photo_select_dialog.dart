import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_select_sample/thumbnail_image.dart';

class SelectedImage {
  final Uint8List thumbnailData;
  final Uint8List originBytes;
  final String id;
  const SelectedImage({
    required this.thumbnailData,
    required this.originBytes,
    required this.id,
  });
}

const int PAGE_SIZE = 100;
const int MAX_COUNT = 10;

class PhotoSelectDialog extends StatefulWidget {
  const PhotoSelectDialog({super.key, required this.maxCount});

  final int maxCount;

  @override
  State<PhotoSelectDialog> createState() => _PhotoSelectDialogState();
}

class _PhotoSelectDialogState extends State<PhotoSelectDialog> {
  List<AssetPathEntity> _albums = [];
  int _selectedAlbumIndex = 0;
  int _currentPage = 0;
  List<AssetEntity> _images = [];
  List<SelectedImage> _selectedImages = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await _requestPermission();
      if (result) {
        await _initAlbums();
        await _initImages();
      }
    });
  }

  Future<bool> _requestPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.hasAccess) {
      return true;
    } else if (!ps.hasAccess && mounted) {
      final response = await showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                children: [
                  Text("권한을 허가해주세요."),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("거부"),
                        onPressed: () {
                          Navigator.pop(context, {"result": false});
                        },
                      ),
                      ElevatedButton(
                        child: Text("허가"),
                        onPressed: () {
                          Navigator.pop(context, {"result": true});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (response["result"]) {
        // パーミッションが拒否された場合の処理
        // 端末のアプリ権限を開く
        await PhotoManager.openSetting();
      } else {
        Navigator.pop(context);
      }
    }
    return false;
  }

  Future<void> _initAlbums() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image,
    );
    setState(() {
      _albums = albums;
    });
  }

  Future<void> _initImages() async {
    List<AssetEntity> images = await _albums[_selectedAlbumIndex]
        .getAssetListPaged(page: _currentPage, size: PAGE_SIZE);
    setState(() {
      _images = images;
    });
  }

  Future<void> _onTapImage(AssetEntity image, bool isSelected) async {
    if (isSelected) {
      setState(() {
        _selectedImages.removeWhere((x) => x.id == image.id);
      });
    } else {
      final thumbnailData = await image.thumbnailData;
      final originBytes = await image.originBytes;
      if (thumbnailData == null || originBytes == null) {
        return;
      }
      if (_selectedImages.length >= widget.maxCount) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("최대 ${widget.maxCount}장까지만 선택할 수 있습니다.")),
        );
        return;
      }
      setState(() {
        _selectedImages.add(
          SelectedImage(
            thumbnailData: thumbnailData,
            originBytes: originBytes,
            id: image.id,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("photo select dialog"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, _selectedImages);
            },
            child: Text("확인")
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          if (_albums.isNotEmpty)
            PopupMenuButton<int>(
              offset: Offset(0, 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_albums[_selectedAlbumIndex].name),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              onSelected: (int index) {
                if (_selectedAlbumIndex != index) {
                  setState(() {
                    _selectedAlbumIndex = index;
                    _currentPage = 0;
                  });
                  _initImages();
                }
              },
              itemBuilder: (BuildContext context) {
                return _albums.asMap().entries.map((entry) {
                  int index = entry.key;
                  AssetPathEntity album = entry.value;

                  return PopupMenuItem<int>(
                    value: index,
                    child: Text(album.name),
                  );
                }).toList();
              },
            ),
          _images.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      bool isSelected = false;
                      for (SelectedImage selectedImage in _selectedImages) {
                        if (selectedImage.id == image.id) {
                          isSelected = true;
                          break;
                        }
                      }
                      // 画像の描画処理
                      return ThumbnailImage(
                        image: image,
                        isSelected: isSelected,
                        onTap: () => _onTapImage(image, isSelected),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
