import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/todo/todo_form.dart';

class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO追加'),
      ),
      body: TodoForm(),
    );
  }
}
