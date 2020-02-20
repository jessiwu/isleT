import 'package:flutter/material.dart';

import 'theme/theme.dart';

class IsletApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isleT',
      // home: HomePage(),
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