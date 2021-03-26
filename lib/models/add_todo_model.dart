import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTodoModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title;

  Future addTodo() async {
    await FirebaseFirestore.instance.collection('todos').add(
      {
        'title': title,
        'createdAt': Timestamp.now(),
      },
    );
  }
}
