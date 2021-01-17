import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';
import 'package:gior/widget/message_bubble.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authPr = Provider.of<Auth>(context);
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: FutureBuilder(
        future: _authPr.getUser(),
        builder: (ctx, futureSnap) {
          if (futureSnap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return StreamBuilder(
            stream: _firestore
                .collection('messages')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (!chatSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.limeAccent,
                  ),
                );
              }
              final messages = chatSnapshot.data.docs;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                  messages[index]['text'],
                  messages[index]['name'],
                  messages[index]['userId'] == futureSnap.data.uid,
                  key: ValueKey(messages[index].documentID),
                ),
                itemCount: messages.length,
              );
            },
          );
        },
      ),
    );
  }
}
