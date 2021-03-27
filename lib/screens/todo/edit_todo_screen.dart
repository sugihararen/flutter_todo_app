import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/widget/todo/todo_form.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  EditTodoScreen(this.todo);

  @override
  Widget build(BuildContext context) {
    return TodoForm(todo: todo);
  }
}
