import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class TextFieldLinear extends StatefulWidget {
  const TextFieldLinear({Key key}) : super(key: key);

  @override
  _TextFieldLinearState createState() => _TextFieldLinearState();
}

class _TextFieldLinearState extends State<TextFieldLinear> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        cursorColor: MyColors.accentColor,
        maxLines: 3,
        minLines: 1,
        validator: (value) {},
        autocorrect: true,
        onSaved: (val) => {},
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyColors.blackLight),
            ),
            suffixIcon:
                IconButton(icon: Icon(Icons.search), onPressed: () => {}),
            hintText: 'Buscar'),
      ),
    );
  }
}

class LengthLimitingTextInputFormatter {}
