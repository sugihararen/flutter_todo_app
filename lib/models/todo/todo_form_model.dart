import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';

class TodoFormModel extends ChangeNotifier {
  final User currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String documentId;
  String title;

  TodoFormModel(Todo todo) {
    if (todo == null) return;

    documentId = todo.documentId;
    title = todo.title;
  }

  Future<void> addTodo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todos')
        .add(
      {
        'title': title,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future<void> editTodo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'title': title,
        'updatedAt': Timestamp.now(),
      },
    );
  }
}
