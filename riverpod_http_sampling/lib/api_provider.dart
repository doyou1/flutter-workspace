import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_http_sampling/api_service.dart';
import 'package:riverpod_http_sampling/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final userListProvider = FutureProvider<List<User>>((ref) async {
  return ref.watch(apiServiceProvider).fetchUser();
});