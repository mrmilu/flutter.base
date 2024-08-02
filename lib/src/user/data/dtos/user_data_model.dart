import 'package:flutter_base/src/user/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable(createToJson: false)
class UserDataModel {
  final int? id;
  final String email;
  @JsonKey(name: 'first_name')
  final String name;
  @JsonKey(name: 'verified')
  final bool activated;

  const UserDataModel({
    this.id,
    required this.email,
    required this.name,
    this.activated = false,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      verified: activated,
    );
  }
}
