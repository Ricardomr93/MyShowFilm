import 'package:flutter/material.dart';
import 'package:myshowfilm/src/pages/login_page.dart';
import 'package:myshowfilm/src/pages/sing_page.dart';
import 'package:myshowfilm/src/pages/splash_screen_page.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShowFilm',
      initialRoute: 'splash', // pantalla inicial
      routes: {
        'splash': (BuildContext context) => SplashScreen(),
        'login': (BuildContext context) => Login(),
        'sing': (BuildContext context) => SingUp(),
      },
      theme: ThemeData(
        textTheme: textTheme,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        backgroundColor: Color(0xff212121),
        primaryColorLight: Color(0xff484848),
        accentColor: Color(0xffd32f2f),
        buttonColor: Color(0xffba000d),
      ),
    );
  }
}
