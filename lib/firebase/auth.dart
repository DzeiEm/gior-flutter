import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user.dart' as us;
import 'dart:async';

class Auth with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  UserCredential _userInfo;
  UserCredential get userInfo {
    return _userInfo;
  }

  User _loggedInUser;

  User get loggedInUser {
    return _loggedInUser;
  }

  us.User _userFromFb(User user) {
    return user != null ? us.User(userId: _loggedInUser.uid) : null;
  }
  // umodel.User _userFromFirebase(User user) {
  //   return user != null ? umodel.User(userId: user.uid) : null;
  // }

  Future<User> getUser() async {
    User _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      print('LOGGED USER INFO: ==> ' + _user.toString());
      _loggedInUser = _user;
      print('LOGGED USER UID : ${_loggedInUser.uid}');
      return _loggedInUser;
    } else {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signUp(
      String email, String password, String name, int phone, int role) async {
    UserCredential _singUpauthResult;
    try {
      _singUpauthResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      createProfile(email, name, phone, role, _singUpauthResult);
      _userInfo = _singUpauthResult;
      print('AUTH RESULT===> $_singUpauthResult');
    } catch (err) {
      print(err.toString());
    }

    // User user = result.user;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    print('USER LOGGED OUT');
    notifyListeners();
  }

  Future<void> autoLogin() async {
    notifyListeners();
  }

  Future<void> createProfile(String email, String name, int phone, int role,
      UserCredential singUpauthResult) async {
    final userId = DateTime.now().toIso8601String();

    if (email == 'admin@admin.com') {
      role = 1;
    } else {
      role = 0;
    }
    try {
      await _firestore.collection('users').doc(singUpauthResult.user.uid).set({
        'user': userId,
        'email': email,
        'name': name,
        'phone': phone,
        'role': role,
      });
      print('AUTH CREATED PROFILE, userID: $userId');
      // print('other profile added:$userId, $email, $name, $phone, $role');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
