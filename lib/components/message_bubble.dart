import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String sender;
  final String text;

  MessageBubble({required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.lightBlueAccent,
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