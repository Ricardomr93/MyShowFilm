import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class ButtomAuth extends StatelessWidget {
  final text;
  final onPressed;
  final width;
  const ButtomAuth(
      {Key key, @required this.text, @required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width == null ? double.infinity : width.toDouble(),
        height: 50,
        margin: EdgeInsets.only(right: 30, left: 30, top: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: MyColors.blackDark,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: TextBold(text: '$text'),
          onPressed: () {
            onPressed();
          },
        ));
  }
}
