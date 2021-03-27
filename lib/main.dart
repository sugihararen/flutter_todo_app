import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/auth/sign_in_screen.dart';
import 'package:flutter_todo_app/screens/auth/sign_up_screen.dart';
import 'package:flutter_todo_app/screens/splash_screen.dart';
import 'package:flutter_todo_app/screens/todo/add_todo_screen.dart';
import 'package:flutter_todo_app/screens/todo/edit_todo_screen.dart';
import 'package:flutter_todo_app/screens/todo/todos_screen.dart';
import 'package:provider/provider.dart';
import 'models/main_model.dart';

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
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/sign_in': (_) => SignInScreen(),
        '/sign_up': (_) => SignUpScreen(),
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..signIn(),
      child: Consumer<MainModel>(
        builder: (
          BuildContext context,
          MainModel mainModel,
          Widget child,
        ) {
          if (mainModel.loading) {
            return SplashScreen();
          }

          if (mainModel.currentUer != null) {
            return TodosScreen();
          }

          return SignInScreen();
        },
      ),
    );
  }
}
