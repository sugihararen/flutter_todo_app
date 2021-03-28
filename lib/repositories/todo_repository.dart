import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/domain/todo.dart';
import 'package:flutter_todo_app/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class TodoRepository {
  Future<List<Todo>> fetchTodos(BuildContext context) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;
    final QuerySnapshot snapshots = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .get();

    return snapshots.docs
        .map(
          (QueryDocumentSnapshot document) => Todo.fromJson(
            {
              'documentId': document.id,
              ...document.data(),
            },
          ),
        )
        .toList();
  }

  Future<void> add(BuildContext context, String title) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .add(
      {
        'title': title,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future<void> edit(
      BuildContext context, String documentId, String title) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'title': title,
        'updatedAt': Timestamp.now(),
      },
    );
  }

  Future<void> delete(BuildContext context, String documentId) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
