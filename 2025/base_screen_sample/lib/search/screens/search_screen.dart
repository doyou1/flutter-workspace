import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/screens/base_screen.dart';
import '../../common/models/bottom_nav_item.dart';
import '../../common/constants/navigation_items.dart';

class SearchScreen extends BaseScreen {
  const SearchScreen({super.key});

  @override
  BaseScreenState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseScreenState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = List.generate(50, (index) => 'Search Result ${index + 1}');
  List<String> _filteredItems = [];

  @override
  void onInitState() {
    super.onInitState();
    _filteredItems = List.from(_allItems);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void onDispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    super.onDispose();
  }

  @override
  void onBottomReached() {
    // 더 많은 검색 결과 로드
    // setState(() {
    //   final newItems = List.generate(10, (index) => 'New Search Result ${_allItems.length + index + 1}');
    //   _allItems.addAll(newItems);
    //   _filterItems(); // 필터 다시 적용
    // });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('More search results loaded!'),
    //     backgroundColor: AppColors.primary,
    //   ),
    // );
  }

  @override
  void onFocusGained() {
    // 검색 필드에 포커스가 갔을 때 키보드 표시
    super.onFocusGained();
  }

  @override
  void onScreenTap() {
    hideKeyboard();
  }

  @override
  bool enableRefreshIndicator() => true;

  @override
  Future<void> onRefresh() async {
    // 검색 결과 새로 고침
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _allItems.clear();
      _allItems.addAll(List.generate(50, (index) => 'Updated Search Result ${index + 1}'));
      _filterItems(); // 현재 검색어에 맞게 필터링
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Search results refreshed!'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Search',
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
          child: TextField(
            controller: _searchController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Search items...',
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primary,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _filterItems();
                      },
                    )
                  : null,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                'Results: ${_filteredItems.length}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filteredItems.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: AppColors.surface,
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.secondary,
                          child: const Icon(
                            Icons.search,
                            color: AppColors.onSecondary,
                          ),
                        ),
                        title: Text(
                          _filteredItems[index],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          'Tap to view details',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.textSecondary,
                          size: 16,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped: ${_filteredItems[index]}'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
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