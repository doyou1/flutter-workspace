import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListViewPage(),
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  var titleList = [
    "Dart",
    "Java",
    "JavaScript",
    "Kotlin",
    "Swift",
    "C#",
    "Dart",
    "Java",
    "JavaScript",
    "Kotlin",
    "Swift",
    "C#",
  ];
  var imageList = [
    "images/avatar1.jpg",
    "images/avatar2.jpg",
    "images/avatar3.jpg",
    "images/avatar4.jpg",
    "images/avatar5.jpg",
    "images/avatar6.jpg",
    "images/avatar1.jpg",
    "images/avatar2.jpg",
    "images/avatar3.jpg",
    "images/avatar4.jpg",
    "images/avatar5.jpg",
    "images/avatar6.jpg",
  ];
  var descriptions = [
    "description1",
    "description2",
    "description3",
    "description4",
    "description5",
    "description6",
    "description1",
    "description2",
    "description3",
    "description4",
    "description5",
    "description6",
  ];

  void showPopup(context, title, image, description) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(image,
                width: 200,
                height: 200,),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title, style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  description,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton.icon(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.close), label: const Text("close"),),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ListView",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
          // return InkWell( // 물감 퍼지듯
            onTap: () {
              debugPrint(titleList[index]);
              showPopup(context, titleList[index], imageList[index], descriptions[index]);
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(imageList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          titleList[index],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width,
                          child: Text(
                            descriptions[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
