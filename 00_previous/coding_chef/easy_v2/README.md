# Free Vertors, Photo
- https://www.freepik.com/

# 새로운 method 정의
```dart
class Book {
  String? title;
  int? number;
  bool? isHardcover;
  int? price;
  
}

Book inputDate(String title, int number, bool isHardcover, int price) {
  print([title, number, isHardcover, price]);
  
  return Book();
}

void main() {
  
  inputDate("BookTitle1", 1500, true, 25000);
  inputDate("BookTitle2", 1700, false, 26000);
  inputDate("BookTitle3", 1600, true, 24000);
}
```

# ListView vs ListView.builder
1. 공통점
- 스크롤이 가능한 배열형 위젯

2. 차이점
- ListView: 리스트뷰안에 모든 차일드를 생성해서 보여줌
- ListView.builder: 그때그때 필요한 만큼만 데이터를 저장소나 서버에서 불러옴