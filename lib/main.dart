import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/pages/edit_profile.dart';
import 'package:myshowfilm/src/pages/main_page.dart';
import 'package:myshowfilm/src/pages/login_page.dart';
import 'package:myshowfilm/src/pages/my_profile_page.dart';
import 'package:myshowfilm/src/pages/sing_page.dart';
import 'package:myshowfilm/src/pages/splash_screen_page.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:myshowfilm/src/providers/auth_provider.dart';
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
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          AuthProvider(), //darle el provider a todos sus hijos
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShowFilm',
        initialRoute: Constants.ROUTE_SPLASH, // pantalla inicial
        routes: {
          Constants.ROUTE_SPLASH: (BuildContext context) => SplashScreenPage(),
          Constants.ROUTE_LOGIN: (BuildContext context) => LoginPage(),
          Constants.ROUTE_SING: (BuildContext context) => SingUpPage(),
          Constants.ROUTE_HOME: (BuildContext context) => MainPage(),
          Constants.ROUTE_PROFILE: (BuildContext context) => MyProfilePage(),
          Constants.ROUTE_EDIT_PROFILE: (BuildContext context) =>
              EditProfilePage(),
        },
        theme: myTheme,
      ),
    );
  }
}
