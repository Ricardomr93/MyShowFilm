import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

class TextBold extends StatelessWidget {
  final text;
  const TextBold({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$text',
        style: TextStyle(
          color: textTheme.bodyText2.color,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
