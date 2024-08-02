class LoginInputModel {
  final String email;
  final String password;

  @override
  int get hashCode => Object.hash(email, password);

  const LoginInputModel({
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      other is LoginInputModel &&
      other.runtimeType == runtimeType &&
      other.hashCode == hashCode;
}
