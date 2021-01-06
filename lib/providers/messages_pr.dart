import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final _firestore = FirebaseFirestore.instance;

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStream() async{
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for ( var message in snapshot.docs) {
        print(message.data());
      }
    }
   
  }
}

// get lauks trigerio
// snapshot pastoviai stalkins