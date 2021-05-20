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
      padding: EdgeInsets.only(top: 130, right: 30, left: 30, bottom: 60),
      child: Center(
        child: Image.asset(
          'assets/img/logo_v.png',
        ),
      ),
    );
  }
}
