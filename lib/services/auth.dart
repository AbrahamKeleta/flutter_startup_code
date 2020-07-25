import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basics/models/user.dart';
import 'package:flutter_basics/services/database.dart';
class Auth  {
  // set the authorization object
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> registerUser(email, password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    DataService(uid: user.uid).saveUser(user); 
    return userFromFirebase(user);
  }


  Future<User> loginUser(email, password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return userFromFirebase(user);
  }

  User userFromFirebase(FirebaseUser user) {
    return User(uid: user.uid, email: user.email);
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged // _auth.
      .map(userFromFirebase);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}