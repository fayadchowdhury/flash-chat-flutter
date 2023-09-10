import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

import 'package:flash_chat/components/message_stream.dart';

class ChatScreen extends StatefulWidget {

  static const String routeId = "chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late User loggedInUser;
  late String message;
  late TextEditingController messageTextController;
  late FirebaseFirestore _messagesDb;
  late FirebaseAuth _auth;

  void getCurrentUser() async {
    try {
      final currentUser = await FirebaseAuth.instance.currentUser;
      if ( currentUser != null ) {
        loggedInUser = currentUser;
      }
    }
    catch (e)
    {
      print(e);
    }
  }

  // This will fetch data from Firestore once it is called
  void getMessages() async
  {
    final messages = await _messagesDb.collection("messages").get().then(
        (querySnapshot) {
          for ( var doc in querySnapshot.docs) {
            print(doc.data());
          }
        }
    );
  }

  // This will listen for changes in Firestore and pull in snapshots (entire collection) once there is a change
  // Bit like Firestore pushing data to the app instead of the app pulling data from Firestore
  void getMessagesStream() async {
    // Involves Streams
    await for ( var snapshot in _messagesDb.collection("messages").snapshots() ) {
      for ( var doc in snapshot.docs ) { // Each doc here is a JsonQueryDocumentSnapshot
        print(doc.data());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    getCurrentUser();
    messageTextController = TextEditingController();
    _messagesDb = FirebaseFirestore.instance;
    // getMessagesStream();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(messagesDb: _messagesDb),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        message = messageTextController.text;
                        String email = loggedInUser.email!;
                        Map<String, String> messageData = {
                          "sender": email,
                          "text": message
                        };
                        _messagesDb.collection("messages").add(messageData);
                      }
                      catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageTextController.dispose();
    super.dispose();
  }
}
