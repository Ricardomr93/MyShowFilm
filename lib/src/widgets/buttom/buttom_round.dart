import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class ButtomRound extends StatelessWidget {
  final onPressed;
  final icon;
  final size;
  final iconSize;
  const ButtomRound(
      {Key key, this.onPressed, @required this.icon, this.size, this.iconSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size == null ? 65 : size.toDouble(),
        height: size == null ? 65 : size.toDouble(),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            primary: MyColors.redDark,
            shape: CircleBorder(),
          ),
          child: Icon(
            icon,
            size: iconSize == null ? 40 : iconSize.toDouble(),
          ),
          onPressed: () => onPressed(),
        ));
  }
}
