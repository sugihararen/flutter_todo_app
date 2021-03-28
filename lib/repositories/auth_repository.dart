import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User currentUser;

  Future signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .update({'updatedAt': Timestamp.now()});

    await saveAccount(email, password);

    currentUser = auth.currentUser;
  }

  Future signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('email');
    prefs.remove('password');

    auth.signOut();
  }

  Future signUp(String email, String password) async {
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user.uid)
        .set({'email': email, 'createdAt': Timestamp.now()});

    currentUser = userCredential.user;

    await saveAccount(email, password);
  }

  Future loadAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.get('email');
    final String password = prefs.get('password');

    if (email == null || password == null) return;

    await signIn(email, password);
  }

  Future saveAccount(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }
}
