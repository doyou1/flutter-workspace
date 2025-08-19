import 'package:flutter/material.dart';

class ScreenB extends StatefulWidget {
  const ScreenB({Key? key}) : super(key: key);

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState is called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose is called");
  }

  @override
  Widget build(BuildContext context) {
    print("build is called");
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScreenB"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Go to Screen A",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
