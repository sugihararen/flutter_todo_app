import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/models/todo/todos_model.dart';
import 'package:flutter_todo_app/widget/loading/overlay_loading.dart';
import 'package:flutter_todo_app/screens/todo/todo_form_screen.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodosModel>(
      create: (_) => TodosModel()..fetchTodos(context),
      child: Consumer<TodosModel>(
        builder: (BuildContext context, TodosModel todosModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'TODOS',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        await todosModel.signOut();
                        Navigator.of(context).pushReplacementNamed('/sign_in');
                      },
                    )
                  ],
                ),
                body: ListView(
                  children: todosModel.todos.map(
                    (Todo todo) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 16,
                          top: 8,
                          right: 16,
                          bottom: 8,
                        ),
                        child: OpenContainer(
                          transitionType: ContainerTransitionType.fadeThrough,
                          transitionDuration: Duration(milliseconds: 700),
                          openBuilder: (BuildContext context, action) =>
                              TodoFormScreen(todo: todo),
                          closedBuilder: (context, action) {
                            return ListTile(
                              title: Text(todo.title),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await todosModel.deleteTodo(
                                      context, todo.documentId);
                                  todosModel.fetchTodos(context);
                                },
                              ),
                            );
                          },
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
                    todosModel.fetchTodos(context);
                  },
                ),
              ),
              OverlayLoading(todosModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
