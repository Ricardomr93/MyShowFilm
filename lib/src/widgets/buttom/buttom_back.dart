import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class ButtomBack extends StatelessWidget {
  const ButtomBack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextBold(
            text: Constants.LABEL_BACK,
          )
        ],
      ),
    );
  }
}
