import 'package:flutter/material.dart';
import 'package:flutter_basics/models/user.dart';
import 'package:flutter_basics/screens/authentication/authentication.dart';
import 'package:flutter_basics/screens/home/user_data.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    if (user == null){
      return Authenticate();
    } else {
      return UserData();
    }
  }
}