import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future GoogleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser == Null)return;
    _user = googleUser;
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();


  }

  Future logout() async {
    try{
      await googleSignIn.disconnect();
    }
    catch(e){}
    FirebaseAuth.instance.signOut();
  }
}