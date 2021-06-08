import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/pages/my_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/tabs/home_tab_cont.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List _children = [
    HomeTabController(),
    Container(),
    MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColors.blackDark,
          onTap: _onTap,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: Constants.NAV_HOME),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: Constants.NAV_SEARCH),
            BottomNavigationBarItem(
                icon: RoundImageProfile(
                  size: 24,
                  image: _auth.currentUser.photoURL != null
                      ? NetworkImage('${_auth.currentUser.photoURL}')
                      : NetworkImage(Constants.IMAGE_PRED),
                ),
                label: _auth.currentUser.displayName != null
                    ? '${_auth.currentUser.displayName}'
                    : Constants.NOM_USER_PRED),
          ],
        ));
  }

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
