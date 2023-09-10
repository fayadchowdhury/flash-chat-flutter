import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flash_chat/components/message_bubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({
    required FirebaseFirestore messagesDb,
    required User user
  }) : _messagesDb = messagesDb, _user = user;

  final FirebaseFirestore _messagesDb;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>( // It is a good idea to specify what the stream type is going to be (QuerySnapshot)
      stream: _messagesDb.collection("messages").snapshots(), // Subscribe to this stream (returns a Stream<QuerySnapshot>)
      builder: (context, snapshot) { // Requires a context and allows access to snapshot
        List<MessageBubble> messageWidgets = [];
        if ( snapshot.hasData ) { // Check to see if snapshot has data or not
          final messages = snapshot.data!.docs.reversed; // Access null-safe snapshot data
          for ( var message in messages ) { // Each message is a JsonQueryDocumentSnapshot
            final messageText = message.get("text"); // This is how we access fields within the JsonQueryDocumentSnapshot
            final messageSender = message.get("sender");
            final bool isLoggedInUser = _user.email == messageSender;
            messageWidgets.add(
                MessageBubble(sender: messageSender, text: messageText, isLoggedInUser: isLoggedInUser) // Add Text widget with relevant text
            );
          }
          return Expanded(
            child: ListView(
              reverse: true, // Keeps ListView  sticky at the bottom
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageWidgets,
            ),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}