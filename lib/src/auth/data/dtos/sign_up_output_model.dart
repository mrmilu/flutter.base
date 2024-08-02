import 'package:flutter_base/src/auth/domain/models/sign_up_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_output_model.g.dart';

@JsonSerializable(createFactory: false)
class SignUpOutputModel {
  @JsonKey(name: 'first_name')
  final String? name;
  final String email;
  final String password;

  const SignUpOutputModel({
    this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignUpOutputModelToJson(this);
}

extension ToOuput on SignUpInputModel {
  SignUpOutputModel toOutput() {
    return SignUpOutputModel(
      name: name,
      email: email,
      password: password,
    );
  }
}
