import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class ButtomRound extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final double size;
  final double iconSize;
  const ButtomRound(
      {Key key, this.onPressed, @required this.icon, this.size, this.iconSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size == null ? 65 : size,
        height: size == null ? 65 : size,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            primary: MyColors.redDark,
            shape: CircleBorder(),
          ),
          child: Icon(
            icon,
            size: iconSize == null ? 40 : iconSize,
          ),
          onPressed: () => onPressed(),
        ));
  }
}
