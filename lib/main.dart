import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/add_todo_screen.dart';
import 'package:flutter_todo_app/screens/todos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodosScreen(),
      routes: <String, WidgetBuilder>{
        '/todos': (_) => TodosScreen(),
        '/todos/new': (_) => AddTodoScreen(),
      },
    );
  }
}
