import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/pages/main_page.dart';
import 'package:myshowfilm/src/pages/login_page.dart';
import 'package:myshowfilm/src/pages/sing_page.dart';
import 'package:myshowfilm/src/pages/splash_screen_page.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //importante para iniciar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //evitar que se pueda girar la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShowFilm',
      initialRoute: 'splash', // pantalla inicial
      routes: {
        'splash': (BuildContext context) => SplashScreenPage(),
        'login': (BuildContext context) => LoginPage(),
        'sing': (BuildContext context) => SingUpPage(),
        'home': (BuildContext context) => MainPage(),
      },
      theme: myTheme,
    );
  }
}
