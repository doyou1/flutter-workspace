import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Charactor card",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("CHARACTER CARD"),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/doyou_moving.gif"),
                  radius: 60.0,
                ),
              ),
              Divider(
                height: 60.0,
                color: Colors.grey[850],
                thickness: 0.5,
                endIndent: 30.0,
              ),
              Text(
                "Text",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "doyou",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "doyou POWER LEVEL",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "10",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "have strong power",
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "make delicious meal",
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "be not late",
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                  )
                ],
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/doyou.jpg"),
                  radius: 60.0,
                  backgroundColor: Colors.amber[800],
                ),
              ),
            ]),
      ),
    );
  }
}
