import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/auth/sign_up_model.dart';
import 'package:flutter_todo_app/widget/overlay_loading.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  String validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Future<void> onPressed(BuildContext context, SignUpModel signUpModel) async {
    if (signUpModel.formKey.currentState.validate()) {
      final response = await signUpModel.signUp();
      if (response != null) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              title: Text(response),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    '閉じる',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.of(context).pushNamed('/todos');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(
        builder: (BuildContext context, SignUpModel signUpModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Sign Up',
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
                  key: signUpModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
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
                          validator: validator,
                          onChanged: (String value) =>
                              signUpModel.email = value.trim(),
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
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
                          obscureText: true,
                          validator: validator,
                          onChanged: (String value) =>
                              signUpModel.password = value.trim(),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          color: Colors.white,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: () => onPressed(context, signUpModel),
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
              OverlayLoading(signUpModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
