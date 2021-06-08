import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/item/friend_item.dart';

class ListFriends extends StatefulWidget {
  ListFriends({Key key}) : super(key: key);

  @override
  ListFriendsState createState() => ListFriendsState();
}

class ListFriendsState extends State<ListFriends> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.3,
            crossAxisSpacing: 10,
          ),
          children: [
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
            FriendItem(),
          ],
          /*itemCount: lista.lenght,
          itemBuilder: (context, index) {
            return FriendItem();
          },*/ //para la implementacion
        ),
      ),
    );
  }
}
