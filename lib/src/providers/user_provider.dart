import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

addUser(UserModel user) {
  return users.doc(user.idUser).set(user.toJson());
}

addUserAuth(FirebaseAuth auth) {
  users.doc(auth.currentUser.uid).get().then((doc) => {
        if (!doc.exists)
          {
            users.doc(auth.currentUser.uid).set({
              Constants.USER_ID: auth.currentUser.uid,
              Constants.USER_EMAIL: auth.currentUser.email,
              Constants.USER_AVATAR: auth.currentUser.photoURL,
              Constants.USER_NAME: auth.currentUser.displayName
            }),
          }
      });
}
