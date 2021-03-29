import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/models/todo/todo_form_model.dart';
import 'package:flutter_todo_app/shared/validator.dart';
import 'package:flutter_todo_app/widget/button/primary_button.dart';
import 'package:flutter_todo_app/widget/loading/overlay_loading.dart';
import 'package:flutter_todo_app/widget/text_field/primary_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TodoFormScreen extends StatelessWidget {
  final Todo todo;
  TodoFormScreen({this.todo});

  Future<void> onPressed(
      BuildContext context, TodoFormModel todoFormModel) async {
    if (todoFormModel.formKey.currentState.validate()) {
      todo == null
          ? await todoFormModel.addTodo(context)
          : await todoFormModel.editTodo(context);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoFormModel>(
      create: (_) => TodoFormModel(todo),
      child: Consumer<TodoFormModel>(
        builder:
            (BuildContext context, TodoFormModel todoFormModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    todo == null ? 'ADD TODO' : 'EDIT TODO',
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
                body: Form(
                  key: todoFormModel.formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        PrimaryTextFormField(
                          hintText: 'Title',
                          textEditingController:
                              todoFormModel.titleEditingController,
                          autofocus: true,
                          validator: (String value) => Validator.empty(value),
                        ),
                        SizedBox(height: 16),
                        PrimaryButton(
                          text: 'SUBMIT',
                          onPressed: () => onPressed(context, todoFormModel),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              OverlayLoading(todoFormModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
