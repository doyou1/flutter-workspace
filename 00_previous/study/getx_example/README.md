# GetX
1. 가벼움
2. 간단함
3. 사용하기 편함

# GetX를 왜 쓰냐
1. State management
2. 코드의 간결성(번거롭고 귀찮을 일을 간단하게 만들어 줌 ex: 페이지 이동)
```dart
// 기존
Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));

// GetX
Get.to(SecondPage());
```

# GetX의 State Management
- Simple State Manager with `GetBuilder`
- Reactive State Manager

# Simple State Manager with `GetBuilder`
- 장점 : Low cost
- 단점 : Manually update
GetX 패키지 설치 => 
Controller 클래스 생성 => 
GetXController 상속 => 
Update 메서드 호출 => 
Dependency Injection(`Get,put`) =>
GetBuilder 호출
`controller.x` 또는 `Get.find<controller>` 사용