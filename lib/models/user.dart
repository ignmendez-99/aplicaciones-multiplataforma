import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SerManosUser {
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
  final Voluntariado? postulacion;

  SerManosUser({
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
    required this.postulacion,
  });

  static Future<SerManosUser> fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) async {
    DocumentReference? voluntariadoPath = json['postulacion'];
    Voluntariado? voluntariado;
    if(voluntariadoPath != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance.doc(voluntariadoPath.path).get();
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      voluntariado = Voluntariado.fromJson(id: snapshot.reference.id, json: data);
    }
    return SerManosUser(
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
      postulacion: voluntariado,
    );
  }
}