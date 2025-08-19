import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Appbar",
        theme: ThemeData(primarySwatch: Colors.red),
        home: MyPage());
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appbar icon menu"),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print("Shopping cart");
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("Search");
              }),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/doyou_moving.gif"),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/doyou.jpg"),
                backgroundColor: Colors.white,
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage("assets/doyou.jpg"),
              //   backgroundColor: Colors.white,
              // ),
            ],
            accountEmail: Text("tla149.japan@mail.com"),
            accountName: Text("doyou"),
            onDetailsPressed: () {
              print("onDetailsPressed");
            },
            decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.grey[850]),
            title: Text("Home"),
            onTap: () {
              print("Home is clicked");
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey[850]),
            title: Text("Setting"),
            onTap: () {
              print("Setting is clicked");
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(Icons.question_answer, color: Colors.grey[850]),
            title: Text("Q&A"),
            onTap: () {
              print("Q&A is clicked");
            },
            trailing: Icon(Icons.add),
          ),
        ],
      )),
    );
  }
}
