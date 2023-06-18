class User {
  final String id;
  final String email;
  final bool emailVerified;
  final List<String> favourites;

  User({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.favourites,
  });

  static User fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return User(
      id: id,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      favourites:List<String>.from(json['favourites'] as List<dynamic>),
    );
  }

  @override
  String toString() {
    return 'User(id:$id, email:$email, emailVerified:$emailVerified, favourites:$favourites)';
  }
}