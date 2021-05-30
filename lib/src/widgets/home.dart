import 'package:flutter/material.dart';
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
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.square(120),
            child: Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: TextBold(text: 'Films'),
                    ),
                    Tab(
                      child: TextBold(text: 'Series'),
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
          ),
        ));
  }
}
