import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000),
        () => Navigator.of(context).pushReplacementNamed('login'));
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
