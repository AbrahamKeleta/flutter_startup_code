class User {
  final uid;
  final email;
  

  User({this.uid, this.email});

  factory User.usersFromFirebase(Map<dynamic, dynamic> jsonData) {
    return User(
      email: jsonData['email'], 
      uid: jsonData['uid']
    );
  }
}