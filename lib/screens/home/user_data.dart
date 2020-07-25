import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/models/user.dart';
import 'package:flutter_basics/services/auth.dart';
import 'package:flutter_basics/services/database.dart';
import 'package:provider/provider.dart';

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final dataRef = FirebaseDatabase.instance.reference().child('recipes');
    return StreamBuilder(
      stream: dataRef.onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          if (snapshot != null) {
            List<User> list = [];
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
            map.forEach((k, v) => list.add(User(email: v['email'], uid: v['uid'])));
            return Users(users: list, currentUser: currentUser);  
          }
        } else {
          return Container();
        }
      }
    );
  }
}

class Users extends StatefulWidget {
  final List<User> users;
  final User currentUser;
  Users({this.users, this.currentUser});
  @override
  UsersState createState() => UsersState();
}

class UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              // Navigate.push => (NewRecipe(user: widget.currentUser));
            },
          ),
      ],),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100, 
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.users.length,
              itemBuilder: (context, index) {
                return SingleUser(user: widget.users[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SingleUser extends StatelessWidget {
  final User user;
  SingleUser({this.user});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${user.email}",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}

