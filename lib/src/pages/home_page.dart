import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ButtomAuth(
          text: 'log out',
          onPressed: () => _logOut(),
        ),
      ),
    );
  }

  _logOut() async {
    utilAlert.showLoadingIndicator(context, 'User trying to login');
    await _auth.signOut().then((value) {
      utilAlert.hideLoadingIndicator(context);
      Navigator.of(context).pushReplacementNamed('login');
    });
  }
}
