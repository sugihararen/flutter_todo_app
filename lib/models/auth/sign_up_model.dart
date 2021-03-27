import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isLoading = false;

  Future signUp() async {
    isLoading = true;
    notifyListeners();

    final String email = emailEditingController.text;
    final String password = passwordEditingController.text;

    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user.uid)
          .set({'email': email, 'createdAt': Timestamp.now()});

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
    } catch (e) {
      emailEditingController.text = '';
      passwordEditingController.text = '';

      return '登録に失敗しました';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
