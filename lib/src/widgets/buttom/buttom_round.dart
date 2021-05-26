import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class ButtomRound extends StatelessWidget {
  final onPressed;
  final icon;
  const ButtomRound({Key key, this.onPressed, @required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 65,
        height: 65,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            primary: myTheme.buttonColor,
            shape: CircleBorder(),
          ),
          child: Icon(
            icon,
            size: 40,
          ),
          onPressed: () => onPressed(),
        ));
  }
}
