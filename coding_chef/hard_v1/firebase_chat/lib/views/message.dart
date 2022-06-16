import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/chat_bubble.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return ChatBubble(chatDocs[index]["text"],
                chatDocs[index]["userID"].toString() == user!.uid);
          },
        );
      },
    );
  }
}
