import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter/material.dart';

class TodosModel extends ChangeNotifier {
  TodosModel() {
    fetchTodos();
  }

  List<Todo> todos = [];

  Future<void> fetchTodos() async {
    final QuerySnapshot snapshots =
        await FirebaseFirestore.instance.collection('todos').get();
    this.todos = snapshots.docs
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
}
