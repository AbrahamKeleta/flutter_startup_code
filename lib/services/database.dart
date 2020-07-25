import 'dart:async';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_basics/models/user.dart';
import 'package:flutter_basics/services/auth.dart';

class DataService {

  final String uid;
  DataService({this.uid});
  final database = FirebaseDatabase.instance;
  // final _controller = StreamController<List<User>>.broadcast();
  // get controllerIn => _controller;

  Future<Void> saveUser(user) {
    final userRef = database.reference().child('users').child(uid);
    userRef.set({
      'uid': user.uid, 
      'email': user.email,
      'user': user
    });
  }  

  

}