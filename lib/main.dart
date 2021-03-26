import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/todo/add_todo_screen.dart';
import 'package:flutter_todo_app/screens/todo/edit_todo_screen.dart';
import 'package:flutter_todo_app/screens/todo/todos_screen.dart';

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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/todos/edit':
            return MaterialPageRoute(
              builder: (context) => EditTodoScreen(settings.arguments),
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
