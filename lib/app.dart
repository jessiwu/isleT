import 'package:flutter/material.dart';
import 'package:islet/search.dart';
import 'package:firebase_core/firebase_core.dart';

import 'theme/theme.dart';
import 'home.dart';
import 'review.dart';
import 'review_page.dart';
import 'logInOrSignUp.dart';
import 'logIn_page.dart';
import 'signUp_page.dart';
import 'logInDialog.dart';

class IsletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'isleT',
    //   home: HomePage(),
    //   // initialRoute: '/',
    //   onGenerateRoute: _getRoute,
    //   theme: kisleTTheme,
    // );

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: LinearProgressIndicator());
        default:
          return MaterialApp(
            title: 'isleT',
            home: HomePage(),
            // initialRoute: '/',
            onGenerateRoute: _getRoute,
            theme: kisleTTheme,
          );
      }
    });
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => HomePage());
      break;
    case '/searchPage':
      return MaterialPageRoute(builder: (context) => SearchPage());
    case '/reviewPage':
      String arg = settings.arguments;
      return MaterialPageRoute(
        // builder: (context) => KoLabHomePage(professorName: arg),
        builder: (context) => ReviewPage(professorName: arg),
      );
      break;
    case '/logInOrSignUpPage':
      return MaterialPageRoute(
        builder: (context) => LogInOrSignUpPage(),
      );
      break;
    case '/logInPage':
      return MaterialPageRoute(
        builder: (context) => LogInPage(),
      );
      break;
    case '/signUpPage':
      return MaterialPageRoute(
        builder: (context) => SignUpPage(),
      );
      break;
    case '/showLogInDialog':
      return MaterialPageRoute(
        builder: (context) => LogInDialog(),
      );
      break;
  }
}
