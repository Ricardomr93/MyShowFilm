import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

final myTheme = ThemeData(
  textTheme: textTheme,
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  backgroundColor: MyColors.blackP,
  primaryColorLight: MyColors.blackLight,
  accentColor: MyColors.accentColor,
  buttonColor: Color(0xffba000d),
);
