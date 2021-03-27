import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodosModel extends ChangeNotifier {
  final User currentUser = FirebaseAuth.instance.currentUser;
  List<Todo> todos = [];
  bool isLoading = true;

  Future<void> fetchTodos() async {
    isLoading = true;
    notifyListeners();

    final QuerySnapshot snapshots = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todos')
        .get();
    todos = snapshots.docs
        .map(
          (QueryDocumentSnapshot document) => Todo.fromJson(
            {
              'documentId': document.id,
              ...document.data(),
            },
          ),
        )
        .toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTodo(String documentId) async {
    isLoading = true;
    notifyListeners();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todos')
        .doc(documentId)
        .delete();

    isLoading = false;
    notifyListeners();
  }

  Future signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('email');
    prefs.remove('password');
  }
}
