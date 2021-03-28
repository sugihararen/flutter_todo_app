import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';
import 'package:flutter_todo_app/repositories/todo_repository.dart';

class TodosModel extends ChangeNotifier {
  List<Todo> todos = [];
  bool isLoading = true;

  Future<void> fetchTodos(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    todos = await TodoRepository().fetchTodos(context);

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTodo(BuildContext context, String documentId) async {
    isLoading = true;
    notifyListeners();

    await TodoRepository().delete(context, documentId);

    isLoading = false;
    notifyListeners();
  }

  Future signOut() async {
    await AuthRepository().signOut();
  }
}
