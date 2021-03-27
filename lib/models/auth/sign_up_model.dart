import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  Future signUp() async {
    isLoading = true;
    notifyListeners();

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);
    } catch (e) {
      email = '';
      password = '';
      notifyListeners();

      return '登録に失敗しました';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
