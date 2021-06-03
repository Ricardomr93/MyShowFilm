import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextBold extends StatelessWidget {
  final String text;
  final bool overflow;
  final FontWeight fontWeight;
  final double fontSize;
  const TextBold(
      {Key key,
      @required this.text,
      this.overflow = false,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$text',
        overflow: overflow ? TextOverflow.ellipsis : null,
        maxLines: overflow ? 2 : null,
        style: TextStyle(
          color: MyColors.textP,
          fontWeight: fontWeight == null ? FontWeight.bold : fontWeight,
          fontSize: fontSize == null ? 16 : fontSize,
        ),
      ),
    );
  }
}
