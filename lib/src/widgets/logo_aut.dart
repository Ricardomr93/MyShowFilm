import 'package:flutter/material.dart';

class LogoAut extends StatefulWidget {
  LogoAut({Key key}) : super(key: key);

  @override
  _LogoAutState createState() => _LogoAutState();
}

class _LogoAutState extends State<LogoAut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Center(
        child: Image.asset(
          'assets/img/logo_v.png',
        ),
      ),
    );
  }
}
