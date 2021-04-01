import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_daily/models/User.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // create a user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(id: user.uid) : null;
  }

  // sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}