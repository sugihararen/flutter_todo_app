import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = true;
  User currentUser;

  Future signIn() async {
    loading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String email = prefs.get('email');
    final String password = prefs.get('password');

    if (email == null || password == null) {
      loading = false;
      notifyListeners();
      return;
    }

    final UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    currentUser = userCredential.user;
    loading = false;
    notifyListeners();
  }
}
