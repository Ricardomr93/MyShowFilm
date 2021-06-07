import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/film_response.dart';
import 'package:myshowfilm/src/data/models/serie_response.dart';
import 'package:myshowfilm/src/pages/film_page.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class HomeTabController extends StatefulWidget {
  HomeTabController({Key key}) : super(key: key);

  @override
  _HomeTabControllerState createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController>
    with TickerProviderStateMixin {
  static const List<Tab> _myTabs = <Tab>[
    Tab(text: Constants.LABEL_FILMS),
    Tab(text: Constants.LABEL_SERIES),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _myTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncSnapshot<FilmResponse> snapshotFilm;
    AsyncSnapshot<SerieResponse> snapshotSerie;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: MyColors.background,
            appBar: PreferredSize(
              preferredSize: Size.square(120),
              child: Padding(
                padding: const EdgeInsets.only(top: 11.0),
                child: AppBar(
                  backgroundColor: MyColors.background,
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 5,
                    tabs: _myTabs,
                  ),
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
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                FilmPage(
                  snapshot: snapshotFilm,
                  type: Constants.LABEL_FILMS,
                ),
                FilmPage(
                  snapshot: snapshotSerie,
                  type: Constants.LABEL_SERIES,
                )
              ],
            )),
      ),
    );
  }
}
