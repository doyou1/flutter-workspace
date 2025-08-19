import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Future",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "data not found";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Future"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  futureTest();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Future test",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "$result$count",
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.redAccent,
                ),
              ),
              const Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              FutureBuilder(
                  future: myFuture(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String data = snapshot!.data as String;
                      return Text(
                        data,
                        style: const TextStyle(fontSize: 20.0, color: Colors.blue,),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // void futureTest() {
  //   Future.delayed(const Duration(seconds: 3)).then((value) {
  //     setState(() {
  //       result = "The data is fetched";
  //       count++;
  //     });
  //   });
  // }
  Future<void> futureTest() async {
    print("Here comes first");
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      print("Here comes second");
      setState(() {
        result = "The data is fetched";
        count++;
        print("Here comes third");
      });
    });
    print("Here comes first");
    print("Here is the last one");
  }

  Future<String> myFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    return "another Future completed$count";
  }
}
