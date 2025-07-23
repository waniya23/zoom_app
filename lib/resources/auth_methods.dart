import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_app/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges=> _auth.authStateChanges();
  User get user=>_auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res=false;
    try {
      // Instantiate GoogleSignIn
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      //if (googleUser == null) return; // The user canceled the sign-in

      // Get authentication object
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
         await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res=true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res=false;
    }
    return res;
  }
  void signOut()async{
    try{
      _auth.signOut();
    }catch(e){
      print(e);
    }
  }
}
