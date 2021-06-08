import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextBold extends StatelessWidget {
  final String text;
  final bool overflow;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;
  final Color color;
  const TextBold(
      {Key key,
      @required this.text,
      this.overflow = false,
      this.fontWeight,
      this.fontSize,
      this.maxLines,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$text',
        overflow: overflow ? TextOverflow.ellipsis : null,
        maxLines: maxLines == null ? null : maxLines,
        style: TextStyle(
          color: color == null ? MyColors.textP : color,
          fontWeight: fontWeight == null ? FontWeight.bold : fontWeight,
          fontSize: fontSize == null ? 16 : fontSize,
        ),
      ),
    );
  }
}
