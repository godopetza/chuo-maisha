import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final String? role;
  final String? interestedIn;
  final String? uid;
  final String? photo;
  final String? gender;
  final Timestamp? age;
  final GeoPoint? location;

  User({
    this.name,
    this.uid,
    this.role,
    this.interestedIn,
    this.photo,
    this.gender,
    this.age,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String?,
        uid: json['uid'] as String?,
        role: json['role'] as String?,
        interestedIn: json['interestedIn'] as String?,
        photo: json['photo'] as String?,
        gender: json['gender'] as String?,
        age: json['age'] as Timestamp?,
        location: json['location'] as GeoPoint?,
      );
}
