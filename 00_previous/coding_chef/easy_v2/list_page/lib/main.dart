import 'package:flutter/material.dart';
import 'package:list_page/animal_page.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  static List<String> animalNames = [
    "Fox",
    "Lion",
    "Bear",
    "Tiger",
    "Cat",
    "Dog",
  ];

  static List<String> animalImagePaths = [
    "images/avatar1.jpg",
    "images/avatar2.jpg",
    "images/avatar3.jpg",
    "images/avatar4.jpg",
    "images/avatar5.jpg",
    "images/avatar6.jpg",
  ];

  static List<String> animalLocations = [
    "forest and moutain",
    "dessert",
    "forest",
    "snow mountain",
    "Australia",
    "Africa",
  ];

  final List<Animal> animals = List.generate(animalNames.length, (index) => Animal(animalNames[index], animalImagePaths[index], animalLocations[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
      ),
      body: ListView.builder(itemCount: animals.length,itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(animals[index].name),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(animals[index].imgPath),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimalPage(animal: animals[index],),
              ),);
              debugPrint(animals[index].name);
            }
          ),
        );
      },),
    );
  }
}
