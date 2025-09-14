import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/navigation_provider.dart';

class MainScreen extends ConsumerWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.uri.path;
    final currentIndex = ref
        .read(navigationNotifierProvider.notifier)
        .getIndexFromLocation(location);

    // URL 변경에 따라 탭 인덱스 동기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationNotifierProvider.notifier).setIndex(currentIndex);
    });

    return Scaffold(
      body: child,
    );
  }
}
