import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/screens/base_screen.dart';
import '../../common/models/bottom_nav_item.dart';
import '../../common/constants/navigation_items.dart';

class ProfileScreen extends BaseScreen {
  const ProfileScreen({super.key});

  @override
  BaseScreenState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreenState<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'John Doe');
  final TextEditingController _emailController = TextEditingController(text: 'john.doe@example.com');
  final TextEditingController _bioController = TextEditingController(text: 'Flutter Developer');

  final List<Map<String, dynamic>> _profileItems = [
    {'title': 'Account Settings', 'icon': Icons.settings, 'subtitle': 'Manage your account'},
    {'title': 'Privacy', 'icon': Icons.privacy_tip, 'subtitle': 'Privacy settings'},
    {'title': 'Notifications', 'icon': Icons.notifications, 'subtitle': 'Notification preferences'},
    {'title': 'Security', 'icon': Icons.security, 'subtitle': 'Security settings'},
    {'title': 'Help & Support', 'icon': Icons.help, 'subtitle': 'Get help and support'},
    {'title': 'About', 'icon': Icons.info, 'subtitle': 'App information'},
    {'title': 'Terms of Service', 'icon': Icons.description, 'subtitle': 'Legal terms'},
    {'title': 'Logout', 'icon': Icons.logout, 'subtitle': 'Sign out of your account'},
  ];

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  void onDispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.onDispose();
  }

  @override
  void onBottomReached() {
    // 추가 설정 옵션 로드
    // setState(() {
    //   _profileItems.addAll([
    //     {'title': 'Dark Mode', 'icon': Icons.dark_mode, 'subtitle': 'Toggle dark theme'},
    //     {'title': 'Language', 'icon': Icons.language, 'subtitle': 'Change app language'},
    //     {'title': 'Export Data', 'icon': Icons.download, 'subtitle': 'Export your data'},
    //   ]);
    // });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('More settings loaded!'),
    //     backgroundColor: AppColors.primary,
    //   ),
    // );
  }

  @override
  void onScreenTap() {
    hideKeyboard();
  }

  @override
  bool onBottomNavTap(int index, String targetRoute) {
    if (index == 2) {
      // Profile 탭을 다시 탭했을 때 스크롤 탑으로 이동
      scrollToTop();
      return true; // 기본 라우팅 방지
    }
    return false; // 다른 탭은 기본 라우팅 수행
  }

  @override
  bool enableRefreshIndicator() => true;

  @override
  Future<void> onRefresh() async {
    // 프로필 정보 새로 고침 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() {
      // 프로필 정보 업데이트
      _nameController.text = 'John Doe (Updated)';
      _emailController.text = 'john.doe.updated@example.com';
      _bioController.text = 'Senior Flutter Developer';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile refreshed!'),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Profile',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _saveProfile,
          child: const Text(
            'Save',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          color: AppColors.surface,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bio',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _bioController,
                  focusNode: focusNode,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Tell us about yourself...',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _profileItems.length,
          itemBuilder: (context, index) {
            final item = _profileItems[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: AppColors.surface,
              elevation: 2,
              child: ListTile(
                leading: Icon(
                  item['icon'],
                  color: item['title'] == 'Logout'
                      ? Colors.red
                      : AppColors.primary,
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(
                    color: item['title'] == 'Logout'
                        ? Colors.red
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'],
                  style: const TextStyle(
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
                      content: Text('Tapped: ${item['title']}'),
                      backgroundColor: item['title'] == 'Logout'
                          ? Colors.red
                          : AppColors.primary,
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  @override
  List<BottomNavItem>? getBottomNavigationItems() => commonNavItems;
}