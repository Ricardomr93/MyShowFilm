import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class ButtomRound extends StatelessWidget {
  const ButtomRound({Key key, this.image}) : super(key: key);
  final image;
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
          child: Image.asset(
            '$image',
            height: 70,
          ),
          onPressed: () {},
        ));
  }
}
