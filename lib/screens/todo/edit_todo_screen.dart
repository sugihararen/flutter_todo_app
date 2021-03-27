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
        centerTitle: true,
        title: Text(
          'TODO編集',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: TodoForm(todo: todo),
    );
  }
}
