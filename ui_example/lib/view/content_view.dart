import 'package:flutter/material.dart';

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  bool isShowLoading = true;
  List<String> stringList = <String>[];
  TextEditingController textEditingController = TextEditingController();

  checkIsShowLoading() {
    if (stringList.isNotEmpty) {
      setState(() {
        isShowLoading = false;
      });
    } else {
      setState(() {
        isShowLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(30.0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Exit"),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: stringList.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: _buildStringList(stringList),
                        )
                      : Text(
                          "Input your message.",
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_circle_outline)),
                        height: 60,
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          controller: textEditingController,
                          key: ValueKey(1),
                          decoration: InputDecoration(
                            hintText: "input text...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        height: 100,
                      ),
                      flex: 6,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            var current = textEditingController.text;
                            if (current != null && current.length != 0) {
                              setState(() {
                                stringList.add(current);
                                textEditingController.clear();
                                checkIsShowLoading();
                              });
                            }
                          },
                          icon: Icon(Icons.mail),
                          label: Text("Send"),
                        ),
                        height: 60,
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStringList(List<String> stringList) {
    return ListView(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: stringList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    child: Text(
                      stringList[index],
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
