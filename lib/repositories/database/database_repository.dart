import 'dart:io';

import 'package:chuomaisha/models/models.dart';
import 'package:chuomaisha/models/user_model.dart';
import 'package:chuomaisha/repositories/repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print('Getting user images from DB');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(user.toMap())
        .then(
          (value) => print('User document updated.'),
        );
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);

    return _firebaseFirestore.collection('users').doc(user.uid).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Stream<List<User>> getUsers(User user) {
    return _firebaseFirestore
        .collection('users')
        .where('interestedIn', isEqualTo: _selectInterest(user))
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<User>> getUsersToSwipe(User user) {
    return Rx.combineLatest2(getUser(user.uid!), getUsers(user), (
      User currentUser,
      List<User> users,
    ) {
      return users.where((user) {
        if (currentUser.swipeLeft!.contains(user.uid)) {
          return false;
        } else if (currentUser.swipeRight!.contains(user.uid)) {
          return false;
        } else if (currentUser.matches!.contains(user.uid)) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  @override
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  ) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(String userId, String matchId) async {
    //Update current user doc
    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([matchId])
    });
    //Update other user doc
    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([userId])
    });
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    return Rx.combineLatest2(getUser(user.uid!), getUsers(user), (
      User currentUser,
      List<User> users,
    ) {
      return users
          .where((user) => currentUser.matches!.contains(user.uid))
          .map((user) => Match(userId: user.uid!, matchedUser: user))
          .toList();
    });

    // return _firebaseFirestore
    //     .collection('users')
    //     .snapshots()
    //     .map((snap) {
    //   return snap.docs
    //       .map((doc) => Match.fromSnapshot(doc, user.uid!))
    //       .toList();
    // });
  }

  _selectInterest(User user) {
    return (user.interestedIn == 'HIRING') ? 'WORK' : 'HIRING';
  }
}
