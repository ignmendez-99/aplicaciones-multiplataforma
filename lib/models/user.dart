import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final bool emailVerified;
  final List<String> favourites;
  final DateTime? birthdate;
  final String? gender;
  final String? phone;
  final bool userUpdated;
  final String firstName;
  final String lastName;
  final String? profilePictureDownloadUrl;

  User({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.favourites,
    this.birthdate,
    this.gender,
    this.phone,
    required this.userUpdated,
    required this.firstName,
    required this.lastName,
    this.profilePictureDownloadUrl,
  });

  static User fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return User(
      id: id,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      favourites: List<String>.from(json['favourites'] as List<dynamic>),
      birthdate: (json['birthdate'] as Timestamp?)?.toDate(),
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      userUpdated: json['user_updated'] as bool,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      profilePictureDownloadUrl: json['profile_picture_download_url'] as String?,
    );
  }
}