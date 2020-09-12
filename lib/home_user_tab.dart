import 'package:flutter/material.dart';
import 'package:islet/theme/colors.dart';

import 'theme/theme.dart';

class UserTab extends StatefulWidget {
  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  _navigateToLogInOrSignUpPage() {
    Navigator.pushNamed(context, '/logInOrSignUpPage');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kisleTPrimaryGreenLight,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
            ),
            _buildButton(),
            // MyButton(),
          ],
        ),
      ),
    );
  }

  _buildButton() {
    return Container(
      child: Center(
        child: RaisedButton(
          key: Key('登入/註冊'),
          onPressed: _navigateToLogInOrSignUpPage,
          child: Text('LogIn/SignUp'),
          color: kisleTSurfaceWhite,
          textColor: kisleTPrimaryGreenDark,
        ),
      ),
    );
  }
}
