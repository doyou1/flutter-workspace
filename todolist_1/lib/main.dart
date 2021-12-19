import 'package:flutter/material.dart';
import 'package:todolist_1/pages/add_event_page.dart';
import 'package:todolist_1/pages/add_task_page.dart';
import 'package:todolist_1/pages/event_page.dart';
import 'package:todolist_1/pages/task_page.dart';
import 'package:todolist_1/widgets/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Montserrat",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(height: 35, color: Theme.of(context).colorScheme.secondary),
        const Positioned(
            right: 0,
            child: Text(
              "6",
              style: TextStyle(fontSize: 200, color: Color(0x10000000)),
            )),
        _mainContent(context),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Dialog(
                    child: AddEventPage(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      )),
    );
  }

  Column _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 60),
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Monday",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        const Expanded(child: EventPage()),
      ],
    );
  }

  Row _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
                onPressed: () {},
                buttonText: "Tasks",
                color: Theme.of(context).colorScheme.secondary,
                textColor: Colors.white)),
        const SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomButton(
          onPressed: () {},
          buttonText: "Events",
          color: Colors.white,
          textColor: Theme.of(context).colorScheme.secondary,
          borderColor: Theme.of(context).colorScheme.secondary,
        )),
      ],
    );
  }
}
