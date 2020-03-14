import 'package:flutter/material.dart';
import 'package:islet/search.dart';

import 'theme/theme.dart';
import 'home.dart';
import 'review.dart';

class IsletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isleT',
      home: SearchPage(),
      onGenerateRoute: _getRoute,
      theme: kisleTTheme,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => SearchPage());
      break;
    case '/reviewPage':
      String arg = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => KoLabHomePage(professorName: arg),
      );
      break;
  }
}