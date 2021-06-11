import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/tabs/tabs_lists/list_friends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendTab extends StatefulWidget {
  FriendTab({Key key}) : super(key: key);

  @override
  _FriendTabState createState() => _FriendTabState();
}

class _FriendTabState extends State<FriendTab> with TickerProviderStateMixin {
  static const List<Tab> _myTabs = <Tab>[
    Tab(text: Constants.LABEL_FOLLOWER),
    Tab(text: Constants.LABEL_FOLLOWED),
  ];

  TabController _tabController;
  CollectionReference usersColl =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  final _auth = FirebaseAuth.instance;
  UserModel us;

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
    return FutureBuilder(
      future: usersColl.doc(_auth.currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          us = UserModel.fromJson(snapshot.data.data());
          return _tabContainer();
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        return ProgressSimple();
      },
    );
  }

  _tabContainer() {
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
                    children: [
                      SizedBox(width: 35),
                      Image.asset(
                        'assets/img/logo_v.png',
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: _tabsbody(),
          )),
    );
  }

  _tabsbody() {
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListFriends(
          type: Constants.LABEL_FOLLOWER,
          listIdUsers: us.followers,
        ),
        ListFriends(
          type: Constants.LABEL_FOLLOWED,
          listIdUsers: us.followed,
        ),
      ],
    );
  }
}
