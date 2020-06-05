import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiestapp/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUidUser() async{
    return _auth.currentUser();
  }
  
  // Getting the user data
  getDataUser() async {
    FirebaseUser user = await _auth.currentUser();

    List<String> lista = List<String>();
    lista.add(user.displayName.toString());
    lista.add(user.email.toString());
    return lista;
  } 

  getUid() async{
    FirebaseUser user = await _auth.currentUser();
    var a = user.uid;
    // print("$a");
    return a;
  }

  //Creating an user object based on FireBase User
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth Change User stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with emacil and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("ERROR");
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      updateUserInfo(name);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("ERRORRRROR");
      print(e.toString());
      return null;
    }
  }

  // Updating the user
  void updateUserInfo(String name) async{
    FirebaseUser user = await _auth.currentUser();
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;
    user.updateProfile(userUpdateInfo);
  }


  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}