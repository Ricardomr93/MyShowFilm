import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class TextFieldGeneral extends StatefulWidget {
  final errorText;
  final hintText;
  final onChanged;
  final message;
  final passtext;

  final TextEditingController controller;
  TextFieldGeneral({
    Key key,
    @required this.hintText,
    this.errorText,
    this.onChanged,
    this.controller,
    this.message,
    this.passtext = false,
  }) : super(key: key);

  @override
  _TextFieldGeneralState createState() => _TextFieldGeneralState();
}

class _TextFieldGeneralState extends State<TextFieldGeneral> {
  bool _obscureText = true;
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
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
            controller: myController,
            cursorColor: myTheme.accentColor,
            obscureText: _obscureText,
            validator: (val) => 'the field must not be empty',
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }
}
