import 'dart:convert';

import 'package:flutter_mvvm_example/model/image_model.dart';
import 'package:http/http.dart' as http;

class ImageService {
  Future<List<ImageModel>> fetchPictureApi() async {
    String url = "https://picsum.photos/v2/list";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      final listResult = json.map((e) => ImageModel.fromJson(e)).toList();
      return listResult;
    } else {
      throw Exception("Error fetching Image");
    }
  }
}