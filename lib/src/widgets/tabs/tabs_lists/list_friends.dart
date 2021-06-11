import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/widgets/item/friend_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListFriends extends StatefulWidget {
  final String type;
  final List<String> listIdUsers;

  ListFriends({Key key, @required this.type, this.listIdUsers})
      : super(key: key);
  @override
  ListFriendsState createState() => ListFriendsState();
}

class ListFriendsState extends State<ListFriends> {
  CollectionReference usersColl =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.3,
            crossAxisSpacing: 10,
          ),
          itemCount: widget.listIdUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return FriendItem(idUser: widget.listIdUsers[index]);
          },
        ),
      ),
    );
  }
}
