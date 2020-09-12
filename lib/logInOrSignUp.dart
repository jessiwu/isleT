import 'package:flutter/material.dart';
import 'package:islet/theme/colors.dart';
import 'theme/theme.dart';

class LogInOrSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _navigateToSignUpPage() {
      Navigator.pushNamed(context, '/signUpPage');
    }

    _navigateToLogInPage() {
      Navigator.pushNamed(context, '/logInPage');
    }

    return Scaffold(
      // appBar: ,
      body: Container(
        color: kisleTPrimaryGreenLight,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 400,
            ),
            ButtonTheme(
              minWidth: 180.0,
              height: 50.0,
              child: RaisedButton(
                key: Key('註冊一個新帳號'),
                onPressed: _navigateToSignUpPage,
                child: Text('Create New Account'),
                color: kisleTPrimaryGreenDark,
                textColor: kisleTSurfaceWhite,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 180.0,
              height: 50.0,
              child: RaisedButton(
                key: Key('登入'),
                onPressed: _navigateToLogInPage,
                child: Text('LogIn'),
                color: kisleTSurfaceWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
