class AuthorModel {
  final String name;
  final String photoUrl;

  AuthorModel({
    required this.name,
    required this.photoUrl,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }
}
