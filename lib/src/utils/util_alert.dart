import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/progress/circular_progress_wait.dart';

//clase de utilidades para las alertas y dialogos

void hideLoadingIndicator(context) => Navigator.of(context).pop();

void showLoadingIndicator(context, [String text]) {
  showDialog(
    context: context,
    barrierDismissible: false, //impide que el usuario cierre pulsando fuera
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async =>
            false, // impide que el usuario cierre con boton retroceso
        child: AlertDialog(
          content: CircularProgressWait(
            text: text,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    },
  );
}

void showAlertDialogGeneral(BuildContext context, String title, String content,
    [onPressed]) {
  showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$content'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context); //cierra la alerta
                  onPressed();
                },
                child: Text('OK'))
          ],
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      });
}

showMaterialDialog(context) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Material Dialog"),
            content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
