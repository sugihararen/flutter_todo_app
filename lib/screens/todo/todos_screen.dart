import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/models/main_model.dart';
import 'package:flutter_todo_app/models/todo/todos_model.dart';
import 'package:flutter_todo_app/widget/overlay_loading.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() {
      context.read<MainModel>().signOut();
    }

    return ChangeNotifierProvider<TodosModel>(
      create: (_) => TodosModel()..fetchTodos(),
      child: Consumer<TodosModel>(
        builder: (BuildContext context, TodosModel todosModel, Widget child) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: <Widget>[
                Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      'TODO一覧',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      Center(
                        child: InkWell(
                          onTap: () => signOut(),
                          child: Text(
                            'SignOut',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 16)
                    ],
                  ),
                  body: ListView(
                    children: todosModel.todos.map(
                      (Todo todo) {
                        return Card(
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
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await todosModel.deleteTodo(todo.documentId);
                                await todosModel.fetchTodos();
                              },
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/todos/new');
                      todosModel.fetchTodos();
                    },
                  ),
                ),
                OverlayLoading(todosModel.isLoading)
              ],
            ),
          );
        },
      ),
    );
  }
}
