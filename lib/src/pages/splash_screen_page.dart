import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/core/constants.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () async {
      //auth
      final _auth = FirebaseAuth.instance;
      //IR A UNA PAGINA U OTRA SEGÚN SI ESTÁ CONECTADO O NO
      if (_auth.currentUser == null) {
        Navigator.of(context).pushReplacementNamed(Constants.ROUTE_LOGIN);
      } else {
        Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
      }
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
