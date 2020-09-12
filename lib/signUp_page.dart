import 'package:flutter/material.dart';
import 'package:islet/theme/colors.dart';

import 'theme/theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up', //'註冊',
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
            _buildPasswordAgainField(),
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
        hintText: 'Enter your email', //'Gmail、Yahoo等常用信箱',
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
        hintText: 'Enter 6 to 12 characters', //'密碼請填入6~12個字元',
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

  _buildPasswordAgainField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Enter your password again', //'請再次輸入密碼',
        labelText: 'Confirm password', //'再次確認密碼',
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
            key: Key('註冊'),
            onPressed: () {},
            child: Text('SignUp'),
            color: kisleTPrimaryGreenDark,
            textColor: kisleTSurfaceWhite,
          ),
        ));
  }
}
