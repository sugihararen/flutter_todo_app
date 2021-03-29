import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/repositories/todo_repository.dart';

class TodoFormModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String documentId;
  TextEditingController titleEditingController = TextEditingController();
  bool isLoading = false;

  TodoFormModel(Todo todo) {
    if (todo == null) return;

    documentId = todo.documentId;
    titleEditingController.text = todo.title;
  }

  Future<void> addTodo(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await TodoRepository().add(
      context,
      titleEditingController.text,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> editTodo(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await TodoRepository().edit(
      context,
      documentId,
      titleEditingController.text,
    );

    isLoading = false;
    notifyListeners();
  }
}
