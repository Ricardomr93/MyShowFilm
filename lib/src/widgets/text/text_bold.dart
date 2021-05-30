import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

class TextBold extends StatelessWidget {
  final text;
  final overflow;
  const TextBold({Key key, @required this.text, this.overflow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$text',
        overflow: overflow ? TextOverflow.ellipsis : null,
        maxLines: overflow ? 2 : null,
        style: TextStyle(
          color: textTheme.bodyText2.color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
