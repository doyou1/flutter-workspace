# Reactive State Manager
1. GetX
2. Obx

# What is the "Reactive"?
a = 4, b = 3
int sum = a + b; => sum = 7;

a = ?, b = ?
int sum = ?

- 보통의 경우 sum은 a와 b가 변하더라도, 재연산을 하지 않는 한, sum의 값은 변하지 않는다.
- Reactive 관점에서 보면, a와 b의 값이 변하면 sum의 값이 지속적으로 변해야 한다.
- 그렇다면, Reactive 관점으로 보면, 우리는 a와 b의 값이 변하는지 지속적으로 `관찰(Observable=Listen)`을 해야 한다. 그리고 최종적으로 UI를 업데이트 시켜줘야 한다.

# 정리
- Reactive = 바로바로 반영한다.
- Reactive state manager = state를 바로바로 반영해 주는 매니저
- **바로바로 = 시간차** = async(비동기) 방식
- 그렇다면 언제 사용하나?
  - 지속적으로 state가 변하는 경우
  - GetX, Obx = Stream 데이터 사용과 같은 의미
  
# Reactive State Manager
1. 자동으로 UI 업데이터
2. GetBuilder보다는 무거우나 부담될 정도는 아님(선택적으로 활용하자)

# What is the Rx?
1. ReactiveX의 줄임말
2. **어떤 데이터 흐름을 '관찰'하는 데에 중점을 둠**
3. 어떤 데이터 Stream = `Observable` <-> `Observer`
- Observable, Observer, Listener interface (Dart Stream과 비슷하네)
- Dart Stream과 다른 점? `Functional` Reactive Programming(FRP)

# MVC pattern
- Reactive State Manager 방식을 사용할 때 *MVC* pattern을 자주 마주하게 될 것이다.
1. 패턴이란?
- 어떤 문제를 해결하기 위한 해법정도로 이해하자
- 디자인 패턴: 설계상에서 발생하는 문제를 해결하기 위한 해법
- M = Model
  - `데이터`를 관리하는 역할
  - 앱이 사용할 데이터를 정의, 수정, 삭제하는 데이터의 *가공* 역할을 함
- V = View
  - 사용자에게 보여지는 `UI`를 관리하는 역할
- C = Controller
  - 독립적으로 일을 수행하는 Model과 View를 연결해줌

# MVC pattern App의 흐름
- `Model`의 `Data`를 `View`에 전달해 출력하고, 
- `View`에서 사용자 이벤트가 발생하면,
- `Controller`에서 `Model`의 `Data`를 변경하고,
- `UI(View)`에 적용된다.

# GetX 최종 정리
- *`Obx`*
  - Observable(obs)의 변화를 listen함
  - Controller 인스턴스가 미리 다른 곳에 initialize 되어 있어야 함
- *`GetX`*
  - Observable(obs)의 변화를 listen함
  - 자체적으로 Controller 인스턴스를 initialize(초기화)할 수도 있음
    - 다른 곳에 controller 객체를 생성하지 않아도 됨
  - Obx보다 다양한 기능을 내장하고 있어서 좀 더 무거움
- *`GetBuilder`*
  - Observable(obs)의 변화를 *listen 하지 않음*
  - 수동으로 UI를 리빌드 해야하기에 반드시 `update` 메서드를 호출해야 함