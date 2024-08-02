import 'package:flutter_base/auth/domain/models/login_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_output_model.g.dart';

@JsonSerializable(createFactory: false)
class LoginOutputModel {
  final String email;
  final String password;

  const LoginOutputModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginOutputModelToJson(this);
}

extension ToOutput on LoginInputModel {
  LoginOutputModel toOutput() {
    return LoginOutputModel(email: email, password: password);
  }
}
