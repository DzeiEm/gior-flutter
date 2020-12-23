import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Auth with ChangeNotifier {
  User loggedInUser;

  Future<User> getUser() async {
    User user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('user  information: ' + user.toString());
      loggedInUser = user;
      print('logged in user:$loggedInUser');
      return loggedInUser;
    } else {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error);
    }
    print('user logged in');

    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    print('user signout');
    notifyListeners();
  }

  Future<void> autoLogin() async {
    notifyListeners();
  }
}
