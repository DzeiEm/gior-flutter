import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MessagesFb {
  final _firestore = FirebaseFirestore.instance;

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  void addMessage(String text, User user) {
    _firestore.collection('messages').add(
      {
        'text': text,
        'sender': user,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
      },
    );
    print('USER UID: ${user.uid}');
    print('USER MESSAGE: $text');
  }
}
