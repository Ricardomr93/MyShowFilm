import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class TextFieldForm extends StatefulWidget {
  final errorText;
  final hintText;
  final passtext;
  final usertext;
  final onSaved;
  final validator;
  final keyboardType;
  final initialValue;

  const TextFieldForm({
    Key key,
    @required this.hintText, // texto de hint
    this.errorText, // texto de error
    @required this.validator, // funcion validador
    this.passtext = false, // es una pass o no
    this.onSaved,
    this.keyboardType = TextInputType.name,
    this.usertext = false,
    this.initialValue,
  }) : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              initialValue:
                  widget.initialValue == null ? null : widget.initialValue,
              textCapitalization:
                  widget.usertext // si es un nombre de usuario capitaliza
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
              decoration: InputDecoration(
                // si es un pass tiene botón y se oculta el texto : no oculta ni muestra boton(null)
                suffixIcon: widget.passtext
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      )
                    : null,
                filled: true,
                fillColor: myTheme.primaryColorLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: myTheme.primaryColorLight),
                ),
                hintText: '${widget.hintText}',
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              keyboardType: widget.keyboardType,
              cursorColor: myTheme.accentColor,
              obscureText: widget.passtext
                  ? _obscureText
                  : false, //si no es una contraseña no ocultar el texto
              onSaved: (val) => widget.onSaved(val),
              validator: (val) => widget.validator(val)),
        )
      ],
    );
  }
}
