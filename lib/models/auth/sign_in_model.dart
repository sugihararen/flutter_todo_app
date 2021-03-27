import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isLoading = false;

  Future signIn() async {
    isLoading = true;
    notifyListeners();

    final String email = emailEditingController.text;
    final String password = passwordEditingController.text;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .update({'updatedAt': Timestamp.now()});

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
    } catch (e) {
      emailEditingController.text = '';
      passwordEditingController.text = '';

      return 'ログインに失敗しました';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
