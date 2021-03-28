import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/auth/sign_in_model.dart';
import 'package:flutter_todo_app/shared/validator.dart';
import 'package:flutter_todo_app/widget/loading/overlay_loading.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  Future<void> onPressed(BuildContext context, SignInModel signInModel) async {
    if (signInModel.formKey.currentState.validate()) {
      final response = await signInModel.signIn(context);
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
          return WillPopScope(
            onWillPop: () async => false,
            child: Stack(
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
                                borderSide:
                                    BorderSide(color: Color(0xffCECECE)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffCECECE)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            autofocus: true,
                            controller: signInModel.emailEditingController,
                            validator: (String value) => Validator.email(value),
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffCECECE)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffCECECE)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            autofocus: true,
                            obscureText: true,
                            controller: signInModel.passwordEditingController,
                            validator: (String value) => Validator.empty(value),
                          ),
                          SizedBox(height: 16),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/sign_up'),
                            child: Text(
                              'Sgin Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
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
            ),
          );
        },
      ),
    );
  }
}
