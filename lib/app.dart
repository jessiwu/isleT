import 'package:flutter/material.dart';
import 'package:islet/search.dart';

import 'theme/theme.dart';
import 'home.dart';

class IsletApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isleT',
      home: SearchPage(),
      // initialRoute: '/login',
      // onGenerateRoute: _getRoute,
      theme: kisleTTheme,
    );
  }
}

// Route<dynamic> _getRoute(RouteSettings settings) {
//   if (settings.name != '/login') {
//     return null;
//   }

//   return MaterialPageRoute<void>(
//     settings: settings,
//     builder: (BuildContext context) => LoginPage(),
//     fullscreenDialog: true,
//   );
// }