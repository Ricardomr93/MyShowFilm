import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class ButtomText extends StatelessWidget {
  const ButtomText(
      {Key key, this.text, this.onPressed, @required this.navigateTo})
      : super(key: key);
  final text;
  final navigateTo;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //Afirma que el contexto dado tiene un ancestro
    //de Localizaciones que contiene un delegado de MaterialLocalizations .
    //Utilizado por muchos widgets de material design para asegurarse de que solo se utilicen en contextos en los que tienen acceso a las localizaciones.
    assert(debugCheckHasMaterialLocalizations(context));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: .5),
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          shadowColor: Colors.transparent),
      child: Text(
        '$text',
        style: TextStyle(
          color: MyColors.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          Navigator.of(context).pushNamed('$navigateTo');
        }
      },
    );
  }
}
