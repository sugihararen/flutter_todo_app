import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  ErrorDialog(this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      title: Text(text),
      actions: <Widget>[
        TextButton(
          child: Text(
            '閉じる',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
