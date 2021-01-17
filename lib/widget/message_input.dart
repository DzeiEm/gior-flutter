import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';
import 'package:gior/firebase/messages_fb.dart';

final _firestore = FirebaseFirestore.instance;

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  Auth _auth = Auth();

  TextEditingController _textController = TextEditingController();
  var _messageText = '';
  final MessagesFb msg = MessagesFb();

  Future<void> _sendMessage() async {

    FocusScope.of(context).unfocus();
    
    final user = await _auth.getUser();
    print('USER ===> $user');
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    print('USER DATA ====> $userData');

    FirebaseFirestore.instance.collection('messages').add({
      'text': _messageText,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'name' : userData['name'],
    });
    // msg.addMessage(_messageText, user);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.purple[100], wordSpacing: 3),
            onChanged: (value) {
              setState(() {
                _messageText = value;
              });
            },
            decoration: InputDecoration(
              enabled: true,
              hintText: 'type here',
              hintStyle: TextStyle(color: Colors.yellow[50].withOpacity(0.7)),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.yellow[50],
          ),
          onPressed: _sendMessage,
        ),
      ],
    );
  }
}
