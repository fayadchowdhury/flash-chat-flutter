import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flash_chat/components/message_bubble.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore messagesDb,
  }) : _messagesDb = messagesDb, super(key: key);

  final FirebaseFirestore _messagesDb;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>( // It is a good idea to specify what the stream type is going to be (QuerySnapshot)
      stream: _messagesDb.collection("messages").snapshots(), // Subscribe to this stream (returns a Stream<QuerySnapshot>)
      builder: (context, snapshot) { // Requires a context and allows access to snapshot
        List<MessageBubble> messageWidgets = [];
        if ( snapshot.hasData ) { // Check to see if snapshot has data or not
          final messages = snapshot.data!.docs; // Access null-safe snapshot data
          for ( var message in messages ) { // Each message is a JsonQueryDocumentSnapshot
            final messageText = message.get("text"); // This is how we access fields within the JsonQueryDocumentSnapshot
            final messageSender = message.get("sender");
            messageWidgets.add(
                MessageBubble(sender: messageSender, text: messageText) // Add Text widget with relevant text
            );
          }
          return Expanded(
            child: ListView(
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