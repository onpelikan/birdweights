import 'package:birds_weights/models/user.dart';
import 'package:birds_weights/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _username = "vazeni@oborazleby.cz";
  static const String _userpass = "Obora2023";

  //create user object based on firebaseuser
  AppUser? _userFromFbUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //create user object based on google user
  AppUser? _userFromGoogleUser(GoogleSignInAccount user) {
    return user != null ? AppUser(uid: user.id) : null;
  }

  //auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFbUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFbUser(user);
    } catch (e) {
      print("CHYBA AUTH.DART");
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(
      {String email = _username, String password = _userpass}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFbUser(user);
    } catch (e) {
      print('*********** ${e.toString()}');
      return null;
    }
  }

  // sign in with google
  Future signInGoogle() async {
    if (kIsWeb) {
      return _signInGoogleWeb();
    } else {
      return _signInGoogleApp();
    }
  }

  Future _signInGoogleWeb() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('https://www.googleapis.com/auth/cloud-platform');
    _auth.signInWithRedirect(googleProvider);
    return _userFromFbUser((await _auth.getRedirectResult()).user);
  }

  Future _signInGoogleApp() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId:
                '811950070445-osl3jof7st3k2h4ml70gis6kkusso7bu.apps.googleusercontent.com')
        .signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final u = await _auth.signInWithCredential(credential);
    return _userFromFbUser(u.user);
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFbUser(user);
    } catch (e) {
      print('*********** ${e.toString()}');
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('********* ${e.toString()}');
      return null;
    }
  }
}
