import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class ProgressSimple extends StatelessWidget {
  const ProgressSimple({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(myTheme.accentColor),
              strokeWidth: 6,
            ),
          ],
        ));
  }
}
