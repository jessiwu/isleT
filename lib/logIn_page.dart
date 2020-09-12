import 'package:flutter/material.dart';
import 'package:islet/theme/colors.dart';

import 'theme/theme.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Log In', //'登入',
          style: TextStyle(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            _buildEmailField(),
            SizedBox(
              height: 20,
            ),
            _buildPasswordField(),
            SizedBox(
              height: 20,
            ),
            _buildSignInButton(),
          ],
        ),
      ),
    );
  }

  _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.email),
        hintText: 'Enter your email', //'請輸入信箱',
        labelText: 'Email *', //'電子信箱 *',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        // return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }

  _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Enter your password', //,'請輸入密碼',
        labelText: 'Password *', //'密碼 *',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        // return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }

  _buildSignInButton() {
    return ButtonTheme(
        minWidth: 180.0,
        height: 50.0,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
          ),
          child: RaisedButton(
            key: Key('登入'),
            onPressed: () {},
            child: Text('LogIn'),
            color: kisleTPrimaryGreenDark,
            textColor: kisleTSurfaceWhite,
          ),
        ));
  }
}
