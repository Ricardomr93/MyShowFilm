import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextFieldTransparent extends StatefulWidget {
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  TextFieldTransparent({
    Key key,
    this.hintText,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldTransparentState createState() => _TextFieldTransparentState();
}

class _TextFieldTransparentState extends State<TextFieldTransparent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(Constants.MAX_LENGTH_COMMENT),
        ],
        textCapitalization: TextCapitalization.sentences,
        keyboardType: widget.keyboardType,
        cursorColor: MyColors.accentColor,
        maxLength: Constants.MAX_LENGTH_COMMENT,
        textInputAction: TextInputAction.send,
        maxLines: 3,
        minLines: 1,
        onChanged: (val) => widget.onChanged(val),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: widget.hintText == null
              ? Constants.TEXT_COMMENT
              : widget.hintText,
        ),
      ),
    );
  }
}
