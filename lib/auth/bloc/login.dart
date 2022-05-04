import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> signOutGoogleUser() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebaseUser() async {
    await _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    print(">> User email:${googleUser.email}");
    print(">> User name:${googleUser.displayName}");
    print(">> User photo:${googleUser.photoUrl}");
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);

    await _createUserCollectionFirebase(_auth.currentUser!.uid,
        _auth.currentUser!.displayName, _auth.currentUser!.email);
  }

  Future<void> _createUserCollectionFirebase(
      String uid, String? name, String? email) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("usuarios").doc(uid).get();

    if (!userDoc.exists) {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(uid)
          .set({"polizas": {}, "nombre": name, "email": email});
    } else {
      return;
    }
  }
}
