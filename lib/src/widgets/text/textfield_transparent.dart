import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextFieldTransparent extends StatefulWidget {
  final String hintText;
  final Function onSaved;
  final TextInputType keyboardType;
  final Function onPressed;
  final Function validator;
  final TextEditingController controller;
  TextFieldTransparent(
      {Key key,
      this.hintText,
      this.keyboardType,
      this.onSaved,
      this.onPressed,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  _TextFieldTransparentState createState() => _TextFieldTransparentState();
}

class _TextFieldTransparentState extends State<TextFieldTransparent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(Constants.MAX_LENGTH_COMMENT),
        ],
        textCapitalization: TextCapitalization.sentences,
        //keyboardType: widget.keyboardType,
        cursorColor: MyColors.accentColor,
        maxLength: Constants.MAX_LENGTH_COMMENT,
        //textInputAction: TextInputAction.newline,
        maxLines: 3,
        minLines: 1,
        validator: (val) => widget.validator(val),
        autocorrect: true,
        onSaved: (val) => widget.onSaved(val),
        decoration: InputDecoration(
          suffixIcon:
              IconButton(icon: Icon(Icons.send), onPressed: widget.onPressed),
          border: OutlineInputBorder(),
          hintText: widget.hintText == null
              ? Constants.TEXT_COMMENT
              : widget.hintText,
        ),
      ),
    );
  }
}
