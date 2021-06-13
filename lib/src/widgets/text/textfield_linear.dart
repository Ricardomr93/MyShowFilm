import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextFieldLinear extends StatefulWidget {
  final Function onSaved;
  final String Function(String) validator;
  final Function onPresed;
  const TextFieldLinear(
      {Key key,
      @required this.onSaved,
      @required this.validator,
      @required this.onPresed})
      : super(key: key);

  @override
  _TextFieldLinearState createState() => _TextFieldLinearState();
}

class _TextFieldLinearState extends State<TextFieldLinear> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      cursorColor: MyColors.accentColor,
      textInputAction: TextInputAction.go,
      maxLines: 3,
      minLines: 1,
      onSaved: (val) => widget.onSaved(val),
      validator: (val) => widget.validator(val),
      autocorrect: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: MyColors.blackLight),
          ),
          suffixIcon:
              IconButton(icon: Icon(Icons.search), onPressed: widget.onPresed),
          hintText: 'Buscar'),
    );
  }
}
