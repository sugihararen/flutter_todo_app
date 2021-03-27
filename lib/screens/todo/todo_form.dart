import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/models/todo/todo_form_model.dart';
import 'package:flutter_todo_app/shared/validator.dart';
import 'package:flutter_todo_app/widget/overlay_loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  final Todo todo;
  TodoForm({this.todo});

  Future<void> onPressed(
      BuildContext context, TodoFormModel todoFormModel) async {
    if (todoFormModel.formKey.currentState.validate()) {
      todo == null
          ? await todoFormModel.addTodo()
          : await todoFormModel.editTodo();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            title: Text('保存しました'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
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
                  centerTitle: true,
                  title: Text(
                    todo == null ? 'TODO追加' : 'TODO編集',
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
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Title',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCECECE)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCECECE)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          autofocus: true,
                          initialValue: todoFormModel.title,
                          validator: (String value) => Validator.empty(value),
                          onChanged: (String value) =>
                              todoFormModel.title = value.trim(),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          color: Colors.white,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: () => onPressed(context, todoFormModel),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
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
