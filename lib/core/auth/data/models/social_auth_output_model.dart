import 'package:flutter_base/core/auth/domain/models/social_auth_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'social_auth_output_model.g.dart';

@JsonSerializable()
class SocialAuthOutputModel {
  final String name;
  final String email;
  final String password;

  const SocialAuthOutputModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SocialAuthOutputModelToJson(this);
}

extension ToOutput on SocialAuthInputModel {
  SocialAuthOutputModel toOutput() {
    return SocialAuthOutputModel(name: name, email: email, password: password);
  }
}
