import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter/material.dart';

class TodosModel extends ChangeNotifier {
  TodosModel() {
    fetchTodos();
  }

  List<Todo> todos = [];

  Future fetchTodos() async {
    final QuerySnapshot snapshots =
        await FirebaseFirestore.instance.collection('todos').get();
    this.todos = snapshots.docs
        .map(
          (QueryDocumentSnapshot doc) => Todo.fromJson(
            doc.data(),
          ),
        )
        .toList();

    notifyListeners();
  }
}
