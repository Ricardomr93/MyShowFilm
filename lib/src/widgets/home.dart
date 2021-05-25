import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.square(120),
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: TextBold(text: 'Films'),
                  ),
                  Tab(
                    child: TextBold(text: 'Series'),
                  ),
                  Tab(
                    child: TextBold(text: 'Lists'),
                  )
                ],
              ),
              backgroundColor: Color(0xff303030),
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/img/logo_v.png',
                    height: 50,
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list_outlined),
                    iconSize: 40,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
