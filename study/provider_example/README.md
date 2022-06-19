# Provider
1. Flutter dev 공식 추천
2. 가장 보편적
3. Provider를 통한 Riverpod과의 연계

# State Management
- State : UI에 변화가 생기도록 영향을 미치는 데이터
    - 데이터는
        - 앱 수준의 데이터
        - 위젯 수준의 데이터
        - 가 있다.

- 그렇다면 이 State를 Management(관리)한다는 건 무엇일까?
    - Management는 보통 "효율"과 관련된다.
    - 앱을 만들다보면, 한번의 setState 호출로 수많은 위젯이 리빌드되는 상황이 벌어진다.
        - 이는 비효율적이다.

# setState method
- setState 메서드는 위젯 라이플 사이클에 Build method를 호출해서 UI를 렌더링하게 만든다.
- Flutter가 기본 제공하는 state management 방법
- 가장 간단하고 확실한 방법이지만, 리빌드할 필요가 없는 위젯들까지 리빌드하게 되는 비효율을 낳는다.

# setState method 사용시 문제점
1. 비효율성
2. 동시에 다른 위젯의 state를 업데이트 시켜주지 못함

# State management 정의
1. 위젯이 쉽게 데이터에 접근할 수 있는 방법을 제공해야 한다.
2. 변화된 데이터에 맞추어서 UI를 다시 그려주는 기능

# Provider.of<FishModel>(context)...
- `of method`는 context를 거슬러 올라가 가장 가까이 있는 원하는 타입의 인스턴스를 찾아서 반환하라는 의미이다.

# class FishModel with ChangeNotifier{
- with는 mixin이다. extend(상속)과 다르다.
- Extend
```dart
// extend
class ButtonPhone {
  String type = "dial phone";
  void function() {
    print("Make a phone call");
  }
}
class SmartPhone extends ButtonPhone {
  String? country;
  int? year;
  SmartPhone(this.country, this.year);
}

void main() {
  // ButtonPhone type & SmartPhone type
  SmartPhone p1 = SmartPhone("Korea", 2022);
  ButtonPhone p2 = SmartPhone("USA", 2022);
  print(p1.country);
  p2.function();
}
```

- with(mixin) 활용- extend
```dart
// mixin
mixin SaveData {
  void addMemory() {
    print("add external memory card...");
  }
}
class ButtonPhone {
  String type = "dial phone";
  void function() {
    print("Make a phone call");
  }
}
class SmartPhone extends ButtonPhone with SaveData{
  String? country;
  int? year;
  SmartPhone(this.country, this.year);
}

void main() {
  // ButtonPhone type & SmartPhone type
  SmartPhone p1 = SmartPhone("Korea", 2022);
  ButtonPhone p2 = SmartPhone("USA", 2022);
  print(p1.country);
  p2.function();
  p1.addMemory();
  // no error
}
```

- Extend(inheritance) vs mixin
  - 결속력의 차이
  - 상속은 결속력이 강함
  - mixin은 결속력이 약함. 기능을 추가하기 위함
    - 다른 클래스에도 기능 추가를 위해 활용할 수 있음
    - dart는 다중상속 허용 X, mixin은 몇개든 가능

# ChangeNotifier의 한계
1. 매번 수동으로 addListener를 등록해 주어야 함
2. 수동으로 addListener를 제거시켜 주어야 함
3. FishModel 인스턴스를 매번 생성자를 통해서 전달 해야 함
4. UI 리빌드도 수동으로 해결해야 함
    - 이에 따라 ChangeNotifierProvider를 사용해야 하게 됨

# ChangeNotifierProvider
1. 모든 위젯들이 listen할 수 있는 ChangeNotifier 인스턴스 생성
2. 자동으로 필요 없는 ChangeNotifier 제거
3. Provider.of를 통해서 위젯들이 쉽게 ChangeNotifier 인스턴스에 접근할 수 있게 해줌
4. 필요시 UI를 리빌드 시켜줄 수 있음
5. 굳이 UI를 리빌드할 필요가 없는 위젯을 위해서 `listen: false` 기능 제공

# MultiProvider
- 한 위젯에서 다른 두 개의 타입의 ChangeNotifierProvider에 접근하고 싶을때 사용
```dart
// Provider만 사용하면 가독성이 떨어짐
Provider(
  create: (context) => ModelA(),
  child: Provider(
    create: (context) => ModelB(),
    child: Provider(
      create: (context) => ModelC(),
      child: MaterialApp(),
    ),
  ),
);

// MultiProvider를 사용하면 간결한 코드가 됨
MultiProvider(
  providers: [
    Provider(create: (context) => ModelA,),
    Provider(create: (context) => ModelB,),
    Provider(create: (context) => ModelC,),
  ],
  child: MaterialApp(),
);
```