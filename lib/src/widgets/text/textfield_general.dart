import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';

class TextFieldForm extends StatefulWidget {
  final errorText;
  final hintText;
  final passtext;
  final onSaved;
  final validator;

  final TextEditingController controller;
  const TextFieldForm({
    Key key,
    @required this.hintText, // texto de hint
    this.errorText, // texto de error
    this.controller, // controlador
    @required this.validator, // funcion validador
    this.passtext = false, // es una pass o no
    this.onSaved,
  }) : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
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
              obscureText: widget.passtext
                  ? true
                  : false, //si no es una contraseña no ocultar el texto
              onSaved: (val) => widget.onSaved(),
              validator: (val) => widget.validator(val)),
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
