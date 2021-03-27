import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter/material.dart';

class TodosModel extends ChangeNotifier {
  final User currentUser = FirebaseAuth.instance.currentUser;
  List<Todo> todos = [];

  Future<void> fetchTodos() async {
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

    notifyListeners();
  }

  Future<void> deleteTodo(String documentId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
