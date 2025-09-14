import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'navigation_provider.g.dart';

@Riverpod(keepAlive: true)
class NavigationNotifier extends _$NavigationNotifier {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }

  void navigateToTab(GoRouter router, int index) {
    setIndex(index);
    switch (index) {
      case 0:
        router.goNamed('home');
        break;
      case 1:
        router.goNamed('search');
        break;
      case 2:
        router.goNamed('profile');
        break;
    }
  }

  int getIndexFromLocation(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/search':
        return 1;
      case '/profile':
        return 2;
      default:
        return 0;
    }
  }
}