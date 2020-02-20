import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData kisleTTheme = _buildisleTTheme();

ThemeData _buildisleTTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kisleTPrimaryGreenLight,
    accentColor: kisleTAccentYellow,
    scaffoldBackgroundColor: kisleTBackgroundWhite,
    cardColor: kisleTBackgroundWhite,
    textSelectionColor: kisleTPrimaryGreenLight,
    errorColor: kisleTErrorRed,

    textTheme: _buildisleTTextTheme(base.textTheme),
    primaryTextTheme: _buildisleTTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildisleTTextTheme(base.accentTextTheme),

    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kisleTAccentYellow,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(
      color: kisleTextTBlack,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0.0)
         )
      ),
    )
  );
}

TextTheme _buildisleTTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w600,
    ),
    title: base.title.copyWith(
      fontSize: 18.0,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),
    display1: base.display1.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16.0
    ),
  ).apply(
    fontFamily: 'NotoSansSC',
    displayColor: kisleTextTBlack,
    bodyColor: kisleTextTBlack,
  );
}
