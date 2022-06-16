import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/message.dart';
import 'package:firebase_chat/views/new_message.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _authentication = FirebaseAuth.instance;
  List<String> chats = [];

  // final _fireStore = ;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat view"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
              // Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(
              child: Message(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
