import 'package:flutter_base/src/auth/domain/models/change_password_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_output_model.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordOutputModel {
  final String uid;
  final String token;
  @JsonKey(name: 'new_password1')
  final String password;
  @JsonKey(name: 'new_password2')
  final String repeatPassword;

  const ChangePasswordOutputModel({
    required this.uid,
    required this.token,
    required this.password,
    required this.repeatPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordOutputModelToJson(this);
}

extension ToOutput on ChangePasswordInputModel {
  ChangePasswordOutputModel toOutput() {
    return ChangePasswordOutputModel(
      uid: uid,
      token: token,
      password: password,
      repeatPassword: repeatPassword,
    );
  }
}
