import 'package:flutter/material.dart';
import 'package:flutter_todo_app/dialog/error_dialog.dart';
import 'package:flutter_todo_app/models/auth/sign_in_model.dart';
import 'package:flutter_todo_app/shared/validator.dart';
import 'package:flutter_todo_app/widget/button/primary_button.dart';
import 'package:flutter_todo_app/widget/loading/overlay_loading.dart';
import 'package:flutter_todo_app/widget/text_field/primary_text_form_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  Future<void> onPressed(BuildContext context, SignInModel signInModel) async {
    if (signInModel.formKey.currentState.validate()) {
      final response = await signInModel.signIn(context);
      if (response != null) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => ErrorDialog(response),
        );
      } else {
        Navigator.of(context).pushReplacementNamed('/todos');
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
                    title: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  body: Form(
                    key: signInModel.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          PrimaryTextFormField(
                            hintText: 'Email',
                            textEditingController:
                                signInModel.emailEditingController,
                            autofocus: true,
                            validator: (String value) => Validator.email(value),
                          ),
                          SizedBox(height: 24),
                          PrimaryTextFormField(
                            hintText: 'Password',
                            textEditingController:
                                signInModel.passwordEditingController,
                            obscureText: true,
                            validator: (String value) => Validator.empty(value),
                          ),
                          SizedBox(height: 16),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/sign_up'),
                            child: Text(
                              'SGIN UP',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(height: 16),
                          PrimaryButton(
                            text: 'SIGN IN',
                            onPressed: () => onPressed(context, signInModel),
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
