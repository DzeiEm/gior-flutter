import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';
import 'package:gior/providers/messages_pr.dart';
import 'package:gior/screens/main%20_screens/settings.dart';

final _firestore = FirebaseFirestore.instance;
Auth auth = Auth();
User me = auth.loggedInUser;

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  Messages msg = Messages();
  String messageText;

  @override
  void initState() {
    auth.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: Colors.yellow[50],
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(SettingsScreen.routeName),
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        cursorColor: Colors.purple,
                        style: TextStyle(
                            color: Colors.purple[100], wordSpacing: 3),
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          enabled: true,
                          hintText: 'type here',
                          hintStyle: TextStyle(
                              color: Colors.yellow[50].withOpacity(0.7)),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.yellow[50]),
                      onPressed: () {
                        _textController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': me.email,
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.limeAccent,
              ),
            );
          }
          final messages = snapshot.data.docs.reversed;

          List<MessageView> messageBubbles = [];
          for (var message in messages) {
            final msgText = message.get('text');
            final msgSender = message.get('sender');

            final currentUser = me.email;
            print('Current user: $currentUser');

            final messageBuble = MessageView(
              sender: msgSender,
              text: msgText,
              isMe: currentUser == msgSender,
            );
            messageBubbles.add(messageBuble);
          }
          print('messagebubbles: $messageBubbles');
          return Expanded(
              child: ListView(
            reverse: true,
            children: messageBubbles,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ));
        },
      ),
    );
  }
}

class MessageView extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  MessageView({this.sender, this.isMe, this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.purple : Colors.yellow[50],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
