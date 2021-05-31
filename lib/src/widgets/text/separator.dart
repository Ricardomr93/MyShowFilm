import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

class MySeparator extends StatelessWidget {
  final text;
  final onPressed;
  final navigateTo;
  final icon;
  final size;
  const MySeparator(
      {Key key,
      @required this.text,
      this.onPressed,
      this.navigateTo,
      @required this.icon,
      this.size = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(right: 30, left: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 15),
            primary: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () => onPressed(),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    icon,
                    size: size == 0.0 ? 19 : size,
                    color: textTheme.bodyText2.color,
                  ),
                ),
                Text(
                  '$text',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textTheme.bodyText2.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
              color: textTheme.bodyText2.color,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
