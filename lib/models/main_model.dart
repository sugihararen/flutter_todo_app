import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class MainModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = true;
  User currentUser;

  Future load(BuildContext context) async {
    loading = true;
    notifyListeners();

    await Provider.of<AuthRepository>(context, listen: false).loadAccount();
    currentUser =
        Provider.of<AuthRepository>(context, listen: false).currentUser;

    loading = false;
    notifyListeners();
  }
}
