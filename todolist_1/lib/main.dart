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
  final PageController _pageController = PageController();

  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
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
                return Dialog(
                    child: currentPage == 0
                        ? const AddTaskPage()
                        : const AddEventPage(),
                    shape: const RoundedRectangleBorder(
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

  Widget _mainContent(BuildContext context) {
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
        Expanded(
            child: PageView(
          controller: _pageController,
          children: const <Widget>[TaskPage(), EventPage()],
        )),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
          buttonText: "Tasks",
          color: currentPage < 0.5
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
          textColor: currentPage < 0.5
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          borderColor: currentPage < 0.5
              ? Colors.transparent
              : Theme.of(context).colorScheme.secondary,
        )),
        const SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
          buttonText: "Events",
          color: currentPage > 0.5
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
          textColor: currentPage > 0.5
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          borderColor: currentPage > 0.5
              ? Colors.transparent
              : Theme.of(context).colorScheme.secondary,
        )),
      ],
    );
  }
}
