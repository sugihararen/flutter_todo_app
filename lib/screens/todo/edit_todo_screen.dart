import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/screens/todo/todo_form.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  EditTodoScreen(this.todo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO編集'),
      ),
      body: TodoForm(todo: todo),
    );
  }
}
