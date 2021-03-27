import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/auth/sign_in_model.dart';
import 'package:flutter_todo_app/widget/overlay_loading.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  String validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Future<void> onPressed(BuildContext context, SignInModel signInModel) async {
    if (signInModel.formKey.currentState.validate()) {
      final response = await signInModel.signIn();
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
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel signInModel, Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                ),
                body: Form(
                  key: signInModel.formKey,
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
                              signInModel.email = value.trim(),
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
                              signInModel.password = value.trim(),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/sign_up'),
                          child: Text(
                            'Sgin Up',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          color: Colors.white,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          onPressed: () => onPressed(context, signInModel),
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
              OverlayLoading(signInModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
