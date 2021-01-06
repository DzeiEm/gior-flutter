import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Auth with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  User _loggedInUser;

  User get loggedInUser {
    return _loggedInUser;
  }

  // umodel.User _userFromFirebase(User user) {
  //   return user != null ? umodel.User(userId: user.uid) : null;
  // }

  Future<User> getUser() async {
    User _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      print('user  information: ' + _user.toString());
      _loggedInUser = _user;
      return _user;
    } else {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      print(err.toString());
    }

    // User user = result.user;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // notifyListeners();
  }

  Future<void> autoLogin() async {
    notifyListeners();
  }

  Future<void> createProfile(
      String email, String name, int phone, int role) async {
    final userId = DateTime.now().toIso8601String();
    if (email == 'admin@admin.com') {
      role = 1;
    } else {
      role = 0;
    }
    try {
      await _firestore.collection('users').add({
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

  Future<void> getUserProfileData() async {
    await _firestore.collection('users').doc().get();
  }

  Future updataUserProfile([String name, int phone, String email]) async {
    return await _firestore.collection('users').doc(_loggedInUser.uid).update({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }
}
