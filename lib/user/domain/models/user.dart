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

  User copyWith({
    int? id,
    String? email,
    String? name,
    bool? verified,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      verified: verified ?? this.verified,
    );
  }
}
