import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../models/bottom_nav_item.dart';

abstract class BaseScreen extends ConsumerStatefulWidget {
  const BaseScreen({super.key});

  @override
  BaseScreenState<BaseScreen> createState();
}

abstract class BaseScreenState<T extends BaseScreen> extends ConsumerState<T>
    with WidgetsBindingObserver {

  late ScrollController scrollController;
  late FocusNode focusNode;

  bool _isKeyboardVisible = false;
  double _currentScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    focusNode = FocusNode();

    scrollController.addListener(_scrollListener);
    focusNode.addListener(_focusListener);
    WidgetsBinding.instance.addObserver(this);

    onInitState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    focusNode.removeListener(_focusListener);
    scrollController.dispose();
    focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);

    onDispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final wasKeyboardVisible = _isKeyboardVisible;
    _isKeyboardVisible = bottomInset > 0;

    if (!wasKeyboardVisible && _isKeyboardVisible) {
      onKeyboardShown();
    } else if (wasKeyboardVisible && !_isKeyboardVisible) {
      onKeyboardHidden();
    }
  }

  void _scrollListener() {
    final offset = scrollController.offset;
    final maxScrollExtent = scrollController.position.maxScrollExtent;

    _currentScrollOffset = offset;
    onScroll(offset, maxScrollExtent);

    // 방향 감지
    if (offset > _currentScrollOffset) {
      onScrollDown(offset);
    } else if (offset < _currentScrollOffset) {
      onScrollUp(offset);
    }

    // 상단/하단 도달 감지
    if (offset >= maxScrollExtent - 100) {
      onBottomReached();
    } else if (offset <= 0) {
      onTopReached();
    }
  }

  void _focusListener() {
    if (focusNode.hasFocus) {
      onFocusGained();
    } else {
      onFocusLost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScreenTap,
      child: Scaffold(
        backgroundColor: getBackgroundColor(context),
        appBar: buildAppBar(context),
        body: _buildBodyWithRefresh(context),
        bottomNavigationBar: _buildBottomNavigationBar(context),
        floatingActionButton: buildFloatingActionButton(context),
        drawer: buildDrawer(context),
      ),
    );
  }

  Widget _buildBodyWithRefresh(BuildContext context) {
    final body = buildBody(context);

    if (enableRefreshIndicator()) {
      return RefreshIndicator(
        onRefresh: () => onRefresh(),
        color: getRefreshIndicatorColor(context) ?? AppColors.primary,
        backgroundColor: getRefreshIndicatorBackgroundColor(context) ?? AppColors.surface,
        child: body,
      );
    }

    return body;
  }

  Widget? _buildBottomNavigationBar(BuildContext context) {
    final customBottomNav = buildBottomNavigationBar(context);
    if (customBottomNav != null) return customBottomNav;

    final items = getBottomNavigationItems();
    if (items == null || items.isEmpty) return null;

    final router = GoRouter.of(context);
    final currentLocation = router.routerDelegate.currentConfiguration.uri.path;

    int getCurrentIndex() {
      for (int i = 0; i < items.length; i++) {
        if (items[i].route == currentLocation) return i;
      }
      return 0;
    }

    return BottomNavigationBar(
      currentIndex: getCurrentIndex(),
      selectedItemColor: getBottomNavSelectedColor(context) ?? AppColors.bottomNavSelected,
      unselectedItemColor: getBottomNavUnselectedColor(context) ?? AppColors.bottomNavUnselected,
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: getShowSelectedLabels(),
      showUnselectedLabels: getShowUnselectedLabels(),
      elevation: 8,
      onTap: (index) {
        final targetRoute = items[index].route;
        final shouldPreventDefault = onBottomNavTap(index, targetRoute);

        if (!shouldPreventDefault) {
          router.go(targetRoute);
        }
      },
      items: items.map((item) {
        final isSelected = item.route == currentLocation;
        return BottomNavigationBarItem(
          icon: Icon(isSelected ? (item.activeIcon ?? item.icon) : item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }

  // 유틸리티 메서드들
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void requestFocus() {
    focusNode.requestFocus();
  }

  // Getter들
  bool get isKeyboardVisible => _isKeyboardVisible;
  double get currentScrollOffset => _currentScrollOffset;
  String get currentRoute => GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;

  // 추상 메서드 - 필수 구현
  Widget buildBody(BuildContext context);

  // Hook 메서드들 - 선택적 구현
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;
  Widget? buildFloatingActionButton(BuildContext context) => null;
  Widget? buildDrawer(BuildContext context) => null;
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  // BottomNavigation 설정
  List<BottomNavItem>? getBottomNavigationItems() => null;
  bool onBottomNavTap(int index, String targetRoute) => false;
  Color? getBottomNavSelectedColor(BuildContext context) => null;
  Color? getBottomNavUnselectedColor(BuildContext context) => null;
  bool getShowSelectedLabels() => true;
  bool getShowUnselectedLabels() => true;

  // 색상 설정
  Color getBackgroundColor(BuildContext context) => AppColors.scaffoldBackground;

  // RefreshIndicator 설정
  bool enableRefreshIndicator() => false;
  Future<void> onRefresh() async {}
  Color? getRefreshIndicatorColor(BuildContext context) => null;
  Color? getRefreshIndicatorBackgroundColor(BuildContext context) => null;

  // 이벤트 Hook 메서드들
  void onInitState() {}
  void onDispose() {}
  void onScroll(double offset, double maxScrollExtent) {}
  void onScrollDown(double offset) {}
  void onScrollUp(double offset) {}
  void onBottomReached() {}
  void onTopReached() {}
  void onKeyboardShown() {}
  void onKeyboardHidden() {}
  void onFocusGained() {}
  void onFocusLost() {}
  void onScreenTap() {}
}