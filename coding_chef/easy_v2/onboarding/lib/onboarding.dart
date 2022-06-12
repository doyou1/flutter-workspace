import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'main.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
        title: "Welcome to my app!",
        body: "This is the first page",
        image: Image.asset("images/woman1.jpg"),
        decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome to my app!",
          body: "This is the second page",
          image: Image.asset("images/woman2.jpg"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Welcome to my app!",
          body: "This is the third page",
          image: Image.asset("images/woman1.jpg"),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text("done"),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MyPage())
        );
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: const Text("skip"),
      dotsDecorator: DotsDecorator(
        color: Colors.cyan,
        size:Size(10, 10),
        activeSize: Size(22, 10),
        activeColor: Colors.red,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      curve: Curves.bounceOut,
    );
  }
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold
    ),
    bodyTextStyle: TextStyle(
      fontSize: 17,
      color:Colors.blue
    ),
    imagePadding: EdgeInsets.only(top: 40),
    pageColor: Colors.orange,
  );
}