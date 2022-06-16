import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  final _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  var _userEnterMessage = "";
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection("chat").add({
      "text": _userEnterMessage,
      "time": Timestamp.now(),
      "userID": user!.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(
        80,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,   // 자동줄바꿈
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Send a message...",
              ),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
