import 'package:flutter_todo_app/models/add_todo_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  String validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Future<void> onPressed(
      BuildContext context, AddTodoModel addTodoModel) async {
    if (addTodoModel.formKey.currentState.validate()) {
      await addTodoModel.addTodo();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました！'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
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
    return ChangeNotifierProvider<AddTodoModel>(
      create: (_) => AddTodoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODOを追加'),
        ),
        body: Consumer<AddTodoModel>(
          builder:
              (BuildContext context, AddTodoModel addTodoModel, Widget child) {
            return Form(
              key: addTodoModel.formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xffCECECE))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCECECE))),
                      ),
                      validator: validator,
                      onChanged: (String value) =>
                          addTodoModel.title = value.trim(),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => onPressed(context, addTodoModel),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
