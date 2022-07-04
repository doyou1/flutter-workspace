### 개념 정리
## StreamBuilder vs FutureBuilder
    - reference: https://flutteragency.com/what-are-streambuilder-and-futurebuilder-in-flutter/
    - 번역 : https://famous-repair-a18.notion.site/What-is-StreamBuilder-and-FutureBuilder-In-Flutter-3264c89879fa4a9799d8c48ccd55a4b2
    - code : study/future_stream

* * *

## [error] One or more plugins require a higher Android SDK version.
    - reference: https://minpro.net/one-or-more-plugins-require-a-higher-android-sdk-version
    - flutter sdk 내부에서 flutter.gradle에서 sdkVersion을 변경해야 함

* * *

## Hive
  - Hive 공부 후, currentUser 유무에 따라 로그인-회원가입화면 / 메인화면 이동 구현

* * *

## Flutter MVVM
  - 공부해야한다, 리팩토링을 위해서

* * *

## Container vs SizedBox
  - reference : https://stackoverflow.com/questions/55716322/flutter-sizedbox-vs-container-why-use-one-instead-of-the-other
  - 번역 : https://www.notion.so/Flutter-SizedBox-VS-Container-why-use-one-instead-of-the-other-Flutter-SizeBox-VS-Container-7b8fe2e023ae400f8924afec15a30987

* * *

## mounted
  - reference: https://stackoverflow.com/questions/65234864/flutter-dart-what-is-mounted-for
  - 번역: https://www.notion.so/Flutter-What-is-mounted-for-6f48f3b2c48c46a09f70ce33e50bfa94


```dart
/// Whether this [State] object is currently in a tree.
///
/// After creating a [State] object and before calling [initState], the
/// framework "mounts" the [State] object by associating it with a
/// [BuildContext]. The [State] object remains mounted until the framework
/// calls [dispose], after which time the framework will never ask the [State]
/// object to [build] again.
///
/// It is an error to call [setState] unless [mounted] is true.

// 이 [State] 개체가 현재 트리에 있는지 여부입니다.
// [State] 객체를 생성하고 [initState]를 호출하기 전에 프레임워크는 [State] 객체를 [BuildContext]와 연결하여 [State] 객체를 "마운트"합니다. [State] 객체는 프레임워크가 [dispose]를 호출할 때까지 마운트된 상태로 유지되며, 그 시간이 지나면 프레임워크는 [State] 객체에 [build]를 다시 요청하지 않습니다.

// [mounted]가 true가 아닌 경우 [setState]를 호출하는 것은 오류입니다.
bool get mounted => _element != null;
```

* * *

## stack widget
- stack widget 주석(comment) 읽어보기 : https://www.notion.so/Flutter-Stack-Widget-Comment-c992acaf86804e60b381d7b592efa3bc

* * *

## didChangeDependencies
- StatefulWidget lifecycle reference: https://flutterbyexample.com/lesson/stateful-widget-lifecycle
- 번역: https://www.notion.so/Flutter-StatefulWidget-lifecycle-5fb3e84f28d646f796411a5a0accd748

* * *
