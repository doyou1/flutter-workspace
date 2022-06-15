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

# For loop
1. For loop 구조
```dart
void forward(int move) {
  for(int i=1; i<=move; i++) {
    print('$i칸 이동했습니다.');
  }
}
forward(5);
```
2. For in loop 구조
```dart
List<String> rainbow = ["빨","주","노","초","파","남","보"];
for(String x in rainbow) {
  print(x);
}
```
3. forEach loop 구조
```dart
List<String> rainbow = ["빨","주","노","초","파","남","보"];
rainbow.forEach((x) {
  print(x);
});
```
4. for loop, for in loop // lotto
```dart
List<int> getLottoNumber() {
  var random = Random();
  List<int> lottoList = [];
  var num;
  
  for(int i=0; i<6; i++) {
    num = random.nextInt(45) + 1;
    lottoList.add(num);
  }
  
  return lottoList;
}
```
5. Set, while loop // lotto
```dart
Set<int> lottoNumber() {
  final random = Random();
  final Set<int> lottoSet = {};
  var num;
  
  while(lottoSet.length != 6) {
    num = random.nextInt(45) + 1;
    lottoSet.add(num);
  }
  
  return lottoSet;
}
```

6. List.generate / for dummy data
```dart
void main() {
  var result = (List<int>.generate(45, (i) => i+1)..shuffle()).subList(0, 6);
}
```

# cascade notation
- The cascade notation (. .) in Dart allows you to make a sequence of operations on the same object (including function calls and field access). This notation helps keep Dart code compact and removes the need to create temporary variables to store data.
- 다트의 계단식 표기법(. .)을 사용하면 함수 호출 및 필드 액세스를 포함하여 동일한 개체에 대해 일련의 작업을 수행할 수 있습니다. 이 표기법은 다트 코드를 컴팩트하게 유지하는 데 도움이 되며 데이터를 저장하기 위해 임시 변수를 만들 필요가 없습니다.
```dart
 eg1
    ..a = 88
    ..bSetter(53)
    ..printValues();
```

# Thread
- 프로세스내에서 실행되는 흐름의 단위
  - Process vs. Program
    - Photoshop이라는 프로그램은 저장장치에 깔려있을 뿐, 데이터 묶음일 뿐
    - 사용자가 Photoshop을 실행시키면, 메모리에 올라가 생명을 얻었다. 프로세스가 됐다.
    - Dart는 싱글 스레드로 운영되는 언어
  - Event loop
    - Dart는 싱글쓰레드로 어떻게 동작하는 걸까?
      - isolate라는 단일 쓰레드와 프로세스가 생성됨
      1. First In First Out(FIFO) 방식으로 "MicroTask와 Event" 준비
         - MicroTask란? 이벤트 큐로 넘어가기전에 비동기적으로 잠시 실행되는 테스크
      2. main함수 실행
      3. Event loop 실행
         1. Button tap, Fetching data, Reading files, drawing gesture, Future Stream
  
# Future
1. 다트에 위해서 Future 객체가 내부적인 배열에 등록
2. Future과 관련해서 실행되어야 하는 코드들이 이벤트 큐에 등록
3. 불완전한 Future 객체가 반환
4. Synchronous 방식으로 실행되어야 할 코드 먼저 실행
5. 최종적으로 실제적인 data 값이 객체로 전달
```dart
void main() {
  print("1");
  Future(() {
    print("2");
  }).then((_) {
    print("3");
  });
  print("4");
}

// 1
// 4
// 2
// 3
```

```dart
void main() async{
  print("1");
  await Future(() {
    print("2");
  });
  print("3");
}

//1
//2
//3
```

```dart
// Synchronous
String createOrderMessage() {
  var order = fetchUserOrder();
  return "Your order is: $order";
}

Future<String> fetchUserOrder() {
  return Future.delayed(
    Duration(seconds: 2),
          () => "Large Latte",
  );
}

void main() {
  print("Fetching user order...");
  print(createOrderMessage());
}

// Fetching user order...
// Your order is: Instance of '_Future<String>'
```

```dart
// async
Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return "Your order is: $order";
}

Future<String> fetchUserOrder() {
  return Future.delayed(
    Duration(seconds: 2),
          () => "Large Latte",
  );
}

void main() async {
  print("Fetching user order...");
  print(await createOrderMessage());
}

// Fetching user order...
// (3 second later)
// Your order is: Large Latte 
```

- Can you understand it?
```dart
void main() async {
  methodA();
  await methodB();
  await methodC("main");
  methodD();
}

methodA() {
  print("A");
}

methodB() async {
  print("B start");
  await methodC("B");
  print("B end");
}

methodC(String from) async {
  print("C start from $from");
  
  Future(() {
    print("C running Future from $from");
  }).then((_) {
    print("C end of Future from $from");
  });
  
  print("C end from $from");
}

methodD() {
  print("D");
}

// A
// B start
// C start from B
// C end from B
// B end
// C start from main
// C end from main
// D
// C running Future from B
// C end of Future from B
// C running Future from main
// C end of Future from main
```

```dart
// methodC에 await 하나 추가
void main() async {
  methodA();
  await methodB();
  await methodC("main");
  methodD();
}

methodA() {
  print("A");
}

methodB() async {
  print("B start");
  await methodC("B");
  print("B end");
}

methodC(String from) async {
  print("C start from $from");

  await Future(() {
    print("C running Future from $from");
  }).then((_) {
    print("C end of Future from $from");
  });

  print("C end from $from");
}

methodD() {
  print("D");
}

// A
// B start
// C start from B
// C running Future from B
// C end of Future from B
// C end from B
// B end
// C start from main
// C running Future from main
// C end of Future from main
// C end from main
// D
```

# Is Google's flutter the future for apps? Or killed by Google?
  - 구글이 폐가힌 227개의 product는 모두 생산성을 담당
  - 지금도 flutter는 전 세계적으로 사용되고 있음
  - 구글이 폐기하려고 하는 프레임워크는 Angularjs 1.x 버전
  - 구글에게 있어서 Fuchsia와 Flutter의 의미

# 1_Null safety in Flutter
- Null : 아직 값이 정해지지 않은 것
- Dart는 Type Safe Language
```dart
class Person {
  속성(변수)
  기능(메서드)
}
```
- 예) class는 한 객체의 속성과 기능을 정의한다.
```dart
int age = null;
```
- int 변수은 변수가 숫자에 대한 정보를 가지고, 연산을 수행한다.
- 그런데 int 변수에 null이 들어가면 연산을 수행할 수 없다.
- null이 프로그램에 문제를 일으킬 수 있지만, 정말 필요한 개념이기도 하다.
  - Food favorite = null에서 null은 favorite food가 없다는 것을 의미한다.
  - 그런데, 이후 프로세스에서 favorite의 값이 null에서 바뀌지 않는다면, 문제가 생긴다.
  ```dart
  void whatIsYourFood(Food f) {
    String cooker = f.recipe.toString();
    print(cooker);
  }
  Food favorite = null;
  whatIsYourFood(favorite); // NullPointException
  ```
  - Null일 수 있는 상황에서 항상 걸려주는 코드를 집어넣어야하는데, 이는 개발자의 실수가 들어갈 수 있고, 코드가 지저분해짐
  - 이를 해결하기 위해서 ***Null Safety***

# 2_Null safety in Flutter
1. 모든 변수는 null이 될 수 없으며, non-nullable 변수에는 null 값을 할당할 수 없음
```dart
// Null Safety가 적용된다면,
void main() {
  String name;    // compile error
  int age = null; // compile error
  print(name);  // compile error
  print(age);   // compile error
}
```
2. non-nullable 변수를 위한 null check가 필요 없음
```dart
// Null Safety가 적용된다면,
int number = 4;

void main() {
  if(number == null) return;  // 해당 조건문은 필요없습니다.
  
  int sum = number + 5;
  print(sum);
}
```
3. ***Class 내의 변수는*** 반드시 선언과 동시에 초기화를 시켜야 함
```dart
class Person {
  int name; // compile error
}
```
- 아래 코드에서 NullPointerException이 발생하는 이유를 찾아보시오.
```dart
// Null Safety 미적용
class Person {
  String name;
  
  String nameChange(String name) {
    this.name = name;
    return name.toUpperCase();
  }
}

void main() {
  Person p = Person();
  // p.name = "doyou";
  print(p.nameChange(p.name));
}
```

- exception을 해결하기 위해선
```dart
class Person {
  String name;
  
  String nameChange(String name) {
    this.name = name;
    return name.toUpperCase();
  }
}

void main() {
  Person p = Person();
  if(p.name == null) {
    print("need a name");
  } else {
    print(p.nameChange(p.name));
  }
}
```

- Null Safety를 사용한다면? 아래와 같이 작성할 수 있다.
```dart
class Person {
  String name;
  
  Person(String name) {
    this.name = name;
  }
  
  String nameChange(String name) {
    this.name = name;
    return name.toUpperCase();
  }
}
void main() {
  Person p = Person("doyou");
  print(p.nameChange(p.name));
}
```

- Null Safety를 사용한다면? 아래와 같이 작성할 수 있다.
```dart
class Person {
  String? name;
  
  String nameChange(String? name) {
    this.name = name;
    if(name == null) {
      return "need a name";
    } else {
      return name.toUpperCase();
    }
  }
}
void main() {
  Person p = Person();
  print(p.nameChange(p.name));
}
```

- Null Safety를 사용한다면? 아래와 같이 작성할 수 있다.
```dart
class Person {
  late int age;
  
  int sum(int age, int num) {
    this.age = age;
    int total = age + num;
    return total + age;
  }
}
void main() {
  Person p = Person();
  print(p.sum(100, 50));
}
```
  - late 예약어는 해당 변수가 class의 생성과 동시에 초기화되지 않음을 의미함

- late 변수
```dart
class Person {
  late int age = calculation();
  
  void printAge() {
    print("age");
  }
}

int calculation() {
  print("calculate");
  return 30;
}

void main() {
  Person p = Person();
  p.printAge();
  print(p.age);
}

// age
// calculate
// 30
``` 

# Widget lifecycle
- Stateless widget
  - 한번 생성되면 절대 바뀌지 않는다.
  - 바꾸고싶다면, destory => rebuild
  - 우리는 build 메서드만 신경쓰면 된다.
- Stateful widget
  - 위젯내의 구성요소들 계속 추적하면서 변화에 반응한다.
  - 변화에 반응하기 위한 생명주기 method가 있다...!
  - initState method
  - build method
  - dispose method, deactivate method
  - 