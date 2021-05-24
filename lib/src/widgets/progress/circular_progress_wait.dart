import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/text_theme.dart';

class CircularProgressWait extends StatelessWidget {
  final text;
  const CircularProgressWait({Key key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_getLoadingIndicator(), _getHeading(), _getText(text)],
          )),
    );
  }

  Widget _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(strokeWidth: 6),
            width: 40,
            height: 40),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading() {
    return Padding(
        child: Text(
          'Please wait …',
          style: TextStyle(
              color: textTheme.bodyText2.color,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Widget _getText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
