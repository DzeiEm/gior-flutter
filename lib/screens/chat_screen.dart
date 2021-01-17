import 'package:flutter/material.dart';
import 'package:gior/widget/message_input.dart';
import 'package:gior/widget/message_steam.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: Colors.yellow[50],
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contact me',
                  style: TextStyle(color: Colors.yellow[50], fontSize: 27),
                ),
                SizedBox(height: 20),
                MessageStream(),
                SizedBox(height: 10),
                MessageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
