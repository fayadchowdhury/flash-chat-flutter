import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String sender;
  final String text;
  final bool isLoggedInUser;

  MessageBubble({required this.sender, required this.text, required this.isLoggedInUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isLoggedInUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w300
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Material(
            elevation: 3.0,
            borderRadius: isLoggedInUser ? BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)) : BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            color: isLoggedInUser ? Colors.lightBlueAccent : Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}