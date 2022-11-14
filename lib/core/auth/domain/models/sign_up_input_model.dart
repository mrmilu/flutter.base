import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';

class SignUpInputModel {
  final String? name;
  final String email;
  final String password;
  final AuthProvider provider;

  const SignUpInputModel({
    this.name,
    required this.email,
    required this.password,
    required this.provider,
  });
}
