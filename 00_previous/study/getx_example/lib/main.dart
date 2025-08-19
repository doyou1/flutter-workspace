import 'package:flutter/material.dart';
import 'package:getx_example/controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dependency Injection
    // ```
    // GetBuilder<Controller>(
    //     init: Controller(),
    // ``` init 속성에 추가하면 아래 코드 필요없음
    // Controller controller = Get.put(Controller());


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GetX"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The return type 'Set<Text>' isn't a 'Widget', as required by the closure's context.
              GetBuilder<Controller>(
                init: Controller(),
                builder: (_) => Text("Current value is : ${Get.find<Controller>().x}"),
                // builder: (_) => Text("Current value is : ${controller.x}"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.find<Controller>().increment();
                },
                child: Text("Add number"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
