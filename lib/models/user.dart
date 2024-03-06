class User {
  final String id;
  final String email;
  final String token;
  String refreshToken;

  User({required this.id, required this.email, required this.token, required this.refreshToken});
}
