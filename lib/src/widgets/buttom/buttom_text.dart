import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class ButtomText extends StatelessWidget {
  final text;
  const ButtomText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: .5),
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          shadowColor: Colors.transparent),
      child: Text(
        '$text',
        style: TextStyle(
          color: myTheme.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: () {},
    );
  }
}
