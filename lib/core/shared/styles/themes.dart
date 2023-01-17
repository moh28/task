import 'package:flutter/material.dart';

import 'package:task_2/core/shared/styles/colors.dart';

import '../../../gen/fonts.gen.dart';
ThemeData lightTheme= ThemeData(
  fontFamily: FontFamily.bold,
  scaffoldBackgroundColor: Colors.white,

  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    /*unselectedItemColor: HexColor('#828282'),*/
    backgroundColor: primaryColor,
  ),
);