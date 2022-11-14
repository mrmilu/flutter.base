class User {
  final int? id;
  final String email;
  final String name;
  final bool verified;

  const User({
    this.id,
    required this.email,
    required this.name,
    this.verified = false,
  });
}
