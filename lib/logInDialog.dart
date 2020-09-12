import 'package:flutter/material.dart';

class LogInDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('請先登入'),
      content: Text('登入後才能評論喔'),
      actions: <Widget>[
        FlatButton(
            key: Key('登入'),
            onPressed: _navigateToLogInOrSignUpPage(context),
            child: Text('登入')),
        FlatButton(
            key: Key('稍後再說'),
            onPressed: _dismissLogInDialog(context),
            child: Text('稍後再說')),
      ],
    );
  }

  _navigateToLogInOrSignUpPage(BuildContext context) {
    Navigator.pushNamed(context, '/logInOrSignUpPage');
  }

  _dismissLogInDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
