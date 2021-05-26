import 'package:flutter/material.dart';
import 'package:myshowfilm/src/pages/login_page.dart';
import 'package:myshowfilm/src/pages/my_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/home.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List _children = [Home(), LoginPage(), MyProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          onTap: _onTap,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: _auth.currentUser != null
                    ? '${_auth.currentUser.displayName}'
                    : 'Usuario'),
          ],
        ));
  }

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
