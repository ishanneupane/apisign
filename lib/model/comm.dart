class User {
  final String title;
  final String image;
  final String redUrl;

  User({
    required this.title,
    required this.image,
    required this.redUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      title: json['Title'] ?? '',
      image: json['Image'] ?? '',
      redUrl: json['RedUrl'] ?? '',
    );
  }
}
