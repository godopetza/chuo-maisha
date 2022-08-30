import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;

  UserRepository(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> signInWithEmail(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> isFirstTime(String userId) async {
    bool userexist = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((user) {
      userexist = user.exists;
    });

    return userexist;
  }

  Future<void> signUpWithEmail(String email, String password) async {
    print(_auth);
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (_auth.currentUser)!.uid;
  }

  //Profile SetUp
}
