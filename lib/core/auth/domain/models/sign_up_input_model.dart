class SignUpInputModel {
  final String? name;
  final String email;
  final String password;

  const SignUpInputModel({
    this.name,
    required this.email,
    required this.password,
  });
}
