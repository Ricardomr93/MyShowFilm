import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () async {
      //auth
      final _auth = FirebaseAuth.instance;
      //TODO IR A UNA PAGINA U OTRA SEGÚN SI ESTÁ CONECTADO O NO
      if (_auth.currentUser == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      // await _auth.signOut(); // TODO para cerrar sesión
      Navigator.of(context).pushReplacementNamed('login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: FractionallySizedBox(
                  widthFactor: .8,
                  child: Image.asset(
                    'assets/img/logo_h.png',
                    height: 300,
                  )),
            ),
            CircularProgressIndicator(),
            Spacer(),
            Text(
              'dev by Rimart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
