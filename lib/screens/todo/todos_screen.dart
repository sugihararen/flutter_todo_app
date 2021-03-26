import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/models/todo/todos_model.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodosModel>(
      create: (_) => TodosModel(),
      child: Consumer<TodosModel>(
        builder: (BuildContext context, TodosModel todosModel, Widget child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('TODO一覧'),
            ),
            body: ListView(
              children: todosModel.todos.map(
                (Todo todo) {
                  return Card(
                    child: Dismissible(
                      key: ObjectKey(todo),
                      onDismissed: (DismissDirection direction) async {
                        await todosModel.deleteTodo(todo.documentId);
                        todosModel.fetchTodos();
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(todo.title),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/todos/edit',
                            arguments: todo,
                          );
                          todosModel.fetchTodos();
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, '/todos/new');
                todosModel.fetchTodos();
              },
            ),
          );
        },
      ),
    );
  }
}
