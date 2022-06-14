# State
- State는 데이터다?
- State란 UI가 변경되도록(렌더링) 영향을 미치는 데이터이다.
- App 수준과 Widget 수준의 데이터가 있다.

# Stateless widget
- State가 변하지 않는 위젯
- Text("Korea") => Text("France")

# Widget tree, Element tree, Render tree
- Widget tree
  - MyApp, Scaffold, AppBar, Text
  - 하나의 설계도, "flutter야! 이렇게 UI를 그려줘!"
- Element tree
  - MyApp element, MyApp element, Scaffold element, AppBar element, Text element
- Render tree
  - Render object, Render object, Render object, Render object

# Widget tree and Element tree
- Reload vs Rebuild
  - Reload : 프레임을 그대로 둔 채, 바뀐 부분만 새로 바꿈
  - Rebuild : 아예 새로 그림, Widget tree내의 모든 Widget은 새로 그려짐
- Are the element tree and render tree rebuilt?
  - 너무 값비싸다, 비효율적이다.
  - flutter는 위젯들의 이전 위치와 타입를 기억하고 있다가, 새롭게 reload 됐을때, 위치와 타입이 변하지 않았다면 새로운 것들만 rebuild한다.
- Container widget update(White > Blue) => Hot reload => build method => Widget tree rebuild => Element tree link update
- *** Stateless 위젯은 rebuild만을 통해서 새로운 State 적용 가능 ***
- Flutter는 초당 60프레임 속도

# Stateful widget
- Input Data(extenal) => Stateful widget(State) => Build method => Renders UI

# State
- Child 위젯의 생성자를 통해서 데이터가 전달될 때
- Internal state가 바뀔 때

# If statement
```
if(오른쪽 길에 장애물이 있다면) {
  왼쪽으로 방향을 틀 것
}
A==b A!=b A&&b A||b A>b A<b A>=b A<=b
```
```dart
void main() {
  grade();
}

void grade() {
  // 1 ~ 100
  int score = Random().nextInt(100) + 1;
  
  print(score);
  if(score <= 50) {
    print("F학점입니다.");
  } else if(score <= 69) {
    print("D학점입니다.");
  } else if(score <= 79) {
    print("C학점입니다.");
  } else if(score <= 89) {
    print("B학점입니다.");
  } else {
    print("A학점입니다.");
  }
}
```

# Focus
- FocusNode: 포커스를 받는 특정 위젯을 식별
- FocusScope: 어떤 위젯들까지 포커스를 받는지 범위를 나타냄
- FocusScope.of(context).unfocus(); : 외부 클릭시, keyboard hide



# const & final
```dart
void main() {
  final int myFinal = 30;
  const int myConst = 70;
  
  // immutable, 수정불가
  myFinal = 20; // compile error
  myConst = 50; // compile error
}
```
- final
```dart
// final 변수는 생성자에서 초기화하는 건 가능
class Person{
  final int age;
  String name;
  Person(this.age, this.name);
}

void main() {
  Person p1 = new Person(21, "Tom");
  print(p1.age);
}
```
<br>
- compile-time constant는 컴파일 시에 상수가 됨
- const 변수는 선언과 동시에 초기화
- const 변수는 컴파일 시에 상수화
- final 변수는 런타임 시에 상수화
- Compile-time constant = Run-time constant
- final 변수는 rebuild 될 수 있음

# future, async, await
```dart
Future<void> fetchUserOrder() {
  return Future.delayed(Duration(seconds: 2), () => print("Large Latter"));
}

void main() {
  fetchUserOrder();
  print("Fetching user order...");
}
```