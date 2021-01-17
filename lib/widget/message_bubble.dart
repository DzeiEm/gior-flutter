
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String name;
  final bool isMe;
  final Key key;
  MessageBubble(this.text, this.name, this.isMe, {this.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
            Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              elevation: 5.0,
              color: isMe ? Colors.teal[800] : Colors.tealAccent[100],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
