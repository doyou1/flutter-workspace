import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/screens/base_screen.dart';
import '../../common/models/bottom_nav_item.dart';
import '../../common/constants/navigation_items.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  BaseScreenState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = List.generate(20, (index) => 'Home Item ${index + 1}');

  void _addItem() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _items.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  @override
  void onDispose() {
    _controller.dispose();
    super.onDispose();
  }

  @override
  void onBottomReached() {
    // 더 많은 아이템 로드
    // setState(() {
    //   final newItems = List.generate(10, (index) => 'New Item ${_items.length + index + 1}');
    //   _items.addAll(newItems);
    // });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('More items loaded!'),
    //     backgroundColor: AppColors.primary,
    //   ),
    // );
  }

  @override
  void onScreenTap() {
    hideKeyboard();
  }

  @override
  bool enableRefreshIndicator() => true;

  @override
  Future<void> onRefresh() async {
    // 새로운 데이터 로드 시뮬레이션
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (index) => 'Refreshed Item ${index + 1}'));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Home data refreshed!'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.surface,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Add new item...',
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.scaffoldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _addItem(),
                ),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                onPressed: _addItem,
                backgroundColor: AppColors.primary,
                child: const Icon(
                  Icons.add,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: AppColors.surface,
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    _items[index],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _items.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  List<BottomNavItem>? getBottomNavigationItems() => commonNavItems;
}