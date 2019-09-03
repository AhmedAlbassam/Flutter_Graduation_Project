import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home.dart';


class UserManagement{

  storeNewUser(user , context) {
    Firestore.instance.collection('/users').add({
      'email':user.email,
      'uid': user.uid
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new HomePage())
      );
    }).catchError((e) {print(e);});
  }
}