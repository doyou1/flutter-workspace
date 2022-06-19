import 'package:flutter_mvvm_example/model/image_model.dart';
import 'package:flutter_mvvm_example/service/image_service.dart';

class ImageListViewModel {
  List<ImageViewModel>? imageList;

  Future<void> fetchPictures() async {
    final apiResult = await ImageService().fetchPictureApi();
    this.imageList = apiResult.map((e) => ImageViewModel(e)).toList();
  }
}

class ImageViewModel {
  final ImageModel? imageModel;

  ImageViewModel(this.imageModel);
}