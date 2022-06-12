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