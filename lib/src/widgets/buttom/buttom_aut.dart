import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/text_bold.dart';

class ButtomAut extends StatelessWidget {
  final text;
  const ButtomAut({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(right: 30, left: 30, top: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: myTheme.buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: TextBold(text: '$text'),
          onPressed: () {},
        ));
  }
}
