# Base Screen Sample - Flutter Template Method Pattern 구현

## 📖 프로젝트 개요

Flutter에서 **Template Method Pattern**을 적용한 공통 화면 기반 클래스(`BaseScreen`)를 구현하고, GoRouter와 Riverpod 3.0을 활용한 현대적인 Flutter 앱 아키텍처를 구축한 샘플 프로젝트입니다.

## 🎯 프로젝트 목적

1. **코드 중복 제거**: 매번 반복되는 ScrollController, FocusNode, 키보드 감지 등의 보일러플레이트 코드 제거
2. **일관된 UI/UX**: 모든 화면에서 동일한 패턴으로 스크롤, 키보드, BottomNavigation 처리
3. **개발 생산성 향상**: 새로운 화면 개발 시 핵심 로직만 구현하면 되는 환경 제공
4. **현대적 아키텍처**: GoRouter + Riverpod 3.0 + Material 3 조합으로 최신 Flutter 개발 방식 적용

## 🏗️ 기술 스택

- **Framework**: Flutter 3.x
- **State Management**: Riverpod 3.0 (@riverpod annotation)
- **Routing**: GoRouter 14.x (ShellRoute 활용)
- **Design Pattern**: Template Method Pattern
- **UI**: Material 3 Design System
- **Code Generation**: build_runner + riverpod_generator

## 🚀 핵심 기능

### 1. BaseScreen Template Method Pattern

```dart
// Before (기존 방식) - 100줄 이상의 보일러플레이트
class ProductListScreen extends StatefulWidget {
  // ScrollController, FocusNode, 키보드 감지, 스크롤 이벤트 등 모든 로직 반복
}

// After (BaseScreen 사용) - 핵심 로직만 30줄
class ProductListScreen extends BaseScreen {
  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      controller: scrollController, // 자동 제공
      // 핵심 UI만 구현
    );
  }

  @override
  void onBottomReached() {
    // 핵심 로직만 구현
  }
}
```

### 2. 자동 제공되는 기능들

- **ScrollController**: 자동 생성 및 관리
- **FocusNode**: 자동 생성 및 관리
- **키보드 감지**: onKeyboardShown/Hidden 이벤트
- **스크롤 이벤트**: onBottomReached, onTopReached 등
- **RefreshIndicator**: enableRefreshIndicator() true만 하면 자동 적용
- **BottomNavigation**: GoRouter와 완전 통합

### 3. Hook 메서드 시스템

```dart
// 이벤트 처리
void onBottomReached() {}     // 하단 도달시
void onKeyboardShown() {}     // 키보드 표시시
void onScreenTap() {}         // 화면 탭시

// UI 구성
Widget buildBody(BuildContext context);              // 필수 구현
PreferredSizeWidget? buildAppBar(BuildContext context); // 선택 구현

// RefreshIndicator
bool enableRefreshIndicator() => true;  // Pull to refresh 활성화
Future<void> onRefresh() async {}        // 새로고침 로직
```

## 📱 구현된 화면

### 1. HomeScreen
- **기능**: 아이템 추가/삭제, 무한 스크롤, Pull to refresh
- **특징**: TextField + FloatingActionButton 조합
- **데모**: 하단 도달시 새 아이템 자동 로드

### 2. SearchScreen
- **기능**: 실시간 검색 필터링, 검색 결과 카운트
- **특징**: prefixIcon + suffixIcon(clear) 조합
- **데모**: 검색어 입력시 즉시 필터링

### 3. ProfileScreen
- **기능**: 프로필 편집, 설정 메뉴, 중복 탭시 스크롤 탑
- **특징**: 커스텀 onBottomNavTap 구현
- **데모**: Profile 탭 재탭시 맨 위로 스크롤

## 🎨 디자인 시스템

### AppColors 중심 일관된 색상 관리
```dart
class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color textPrimary = Color(0xFF333333);
  // ...
}
```

### AppTheme 통합 테마 시스템
- Material 3 기반 ColorScheme
- BottomNavigationBarThemeData 통합
- Typography 일관성 보장

## 🛠️ 아키텍처 구조

```
lib/
├── common/
│   ├── screens/
│   │   ├── base_screen.dart          # Template Method Pattern 핵심
│   │   └── main_screen.dart          # ShellRoute 래퍼
│   ├── theme/
│   │   ├── app_colors.dart           # 색상 상수 관리
│   │   └── app_themes.dart           # Material 3 테마
│   ├── router/
│   │   └── app_router.dart           # GoRouter 설정
│   ├── providers/
│   │   └── navigation_provider.dart   # 네비게이션 상태 관리
│   ├── models/
│   │   └── bottom_nav_item.dart      # BottomNav 모델
│   └── constants/
│       └── navigation_items.dart     # 공통 네비게이션 아이템
├── home/screens/home_screen.dart
├── search/screens/search_screen.dart
├── profile/screens/profile_screen.dart
└── main.dart
```

## 📊 개발 효과

| 항목 | Before | After | 개선 효과 |
|------|--------|-------|-----------|
| 개발 시간 | 2시간 | 1시간 | **50% 단축** |
| 코드 라인 수 | ~100줄 | ~30줄 | **70% 감소** |
| 버그 발생률 | 높음 | 낮음 | **검증된 공통 로직** |
| 유지보수성 | 낮음 | 높음 | **중앙 집중식 관리** |

## 🚀 실행 방법

### 1. 의존성 설치
```bash
flutter pub get
```

### 2. 코드 생성
```bash
dart run build_runner build
```

### 3. 앱 실행
```bash
flutter run
```

## 🔧 Riverpod 3.0 적용

### Provider 정의
```dart
@Riverpod(keepAlive: true)
class NavigationNotifier extends _$NavigationNotifier {
  @override
  int build() => 0;

  void navigateToTab(GoRouter router, int index) {
    // 탭 네비게이션 로직
  }
}
```

### 사용법
```dart
// 상태 감지
final currentIndex = ref.watch(navigationNotifierProvider);

// 메서드 호출
ref.read(navigationNotifierProvider.notifier).navigateToTab(router, index);
```

## 🎯 GoRouter 통합

### ShellRoute 구조
```dart
ShellRoute(
  builder: (context, state, child) => MainScreen(child: child),
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/search', name: 'search', builder: (context, state) => SearchScreen()),
    GoRoute(path: '/profile', name: 'profile', builder: (context, state) => ProfileScreen()),
  ],
)
```

### BottomNavigation 자동 동기화
- URL 변경시 탭 상태 자동 업데이트
- 브라우저 뒤로가기/앞으로가기 지원
- 직접 URL 접근시에도 올바른 탭 선택

## 💡 BaseScreen 사용법

### 기본 사용
```dart
class MyScreen extends BaseScreen {
  @override
  BaseScreenState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends BaseScreenState<MyScreen> {
  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      controller: scrollController, // BaseScreen에서 제공
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );
  }

  @override
  List<BottomNavItem>? getBottomNavigationItems() => commonNavItems;
}
```

### RefreshIndicator 사용
```dart
@override
bool enableRefreshIndicator() => true;

@override
Future<void> onRefresh() async {
  await Future.delayed(Duration(seconds: 2));
  if (!mounted) return;

  setState(() {
    // 데이터 새로고침
  });
}
```

### 무한 스크롤 구현
```dart
@override
void onBottomReached() {
  setState(() {
    // 추가 데이터 로드
  });
}
```

## 📋 주요 Hook 메서드

### 필수 구현
- `Widget buildBody(BuildContext context)` - 메인 화면 구성

### 선택적 구현
- `PreferredSizeWidget? buildAppBar(BuildContext context)` - 앱바
- `List<BottomNavItem>? getBottomNavigationItems()` - 하단 네비게이션
- `bool enableRefreshIndicator()` - Pull to refresh 활성화
- `Future<void> onRefresh()` - 새로고침 로직
- `void onBottomReached()` - 하단 도달시 실행
- `void onScreenTap()` - 화면 탭시 실행
- `bool onBottomNavTap(int index, String targetRoute)` - 탭 커스터마이징

## 🎨 커스터마이징

### 색상 커스터마이징
```dart
@override
Color? getRefreshIndicatorColor(BuildContext context) => Colors.blue;

@override
Color getBackgroundColor(BuildContext context) => Colors.grey[50]!;
```

### BottomNavigation 커스터마이징
```dart
@override
bool onBottomNavTap(int index, String targetRoute) {
  if (index == 2) {
    scrollToTop(); // 프로필 탭 재탭시 스크롤 탑
    return true;   // 기본 라우팅 방지
  }
  return false;    // 기본 라우팅 수행
}
```

## 📈 확장 가능성

### 추가 구현 가능한 기능들
- **Pull to Refresh**: ✅ 이미 구현됨
- **무한 스크롤**: ✅ onBottomReached로 구현됨
- **검색 기능**: ✅ SearchScreen에서 구현됨
- **키보드 관리**: ✅ 자동 처리됨
- **포커스 관리**: ✅ FocusNode 자동 제공
- **애널리틱스 추적**: Hook 메서드에 추가 가능
- **테마 변경**: AppTheme 확장으로 구현 가능

## 🏆 비즈니스 가치

### 개발팀 관점
- **신입 개발자 온보딩 시간 단축**: 패턴 학습 효과
- **코드 리뷰 시간 절약**: 표준화된 구조
- **버그 감소**: 검증된 공통 로직 사용

### 프로젝트 관점
- **개발 속도 2배 향상**: 보일러플레이트 제거
- **유지보수 비용 절감**: 중앙집중식 관리
- **일관된 UX**: 모든 화면에서 동일한 동작 패턴

## 📚 학습 리소스

### 관련 디자인 패턴
- **Template Method Pattern**: 알고리즘 구조 정의, 확장 지점 제공
- **Hook Method Pattern**: 특정 시점에 커스텀 로직 주입
- **Observer Pattern**: 이벤트 리스너 구현

### 권장 학습 순서
1. Flutter 기본기 (StatefulWidget, State 관리)
2. GoRouter 사용법 및 ShellRoute 이해
3. Riverpod 3.0 @riverpod annotation 방식
4. Template Method Pattern 개념 이해
5. BaseScreen 실제 적용 및 커스터마이징

---

## 💬 한 줄 요약

> "매번 반복되는 스크롤, 키보드, BottomNav 설정을 **BaseScreen 한 번만 구현**해두고, 새 화면은 **핵심 로직만 30줄로 끝**내는 생산성 향상 아키텍처입니다. 🚀"

---

## 📄 라이센스

이 프로젝트는 학습 및 참고 목적으로 제작되었습니다.

## 🤝 기여

이슈 제보나 개선 제안은 언제든 환영합니다!