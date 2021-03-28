import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class SignUpModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isLoading = false;

  Future signUp(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final String email = emailEditingController.text;
    final String password = passwordEditingController.text;

    try {
      await Provider.of<AuthRepository>(context, listen: false)
          .signUp(email, password);
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
