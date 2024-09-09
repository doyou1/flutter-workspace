import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_http_sampling/user_model.dart';

class ApiService {
  final String baseUrl = "https://reqres.in/api";

  Future<List<User>> fetchUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to Load the User');
    }
  }
}
