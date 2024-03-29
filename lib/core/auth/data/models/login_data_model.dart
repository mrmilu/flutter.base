import 'package:json_annotation/json_annotation.dart';

part 'login_data_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginDataModel {
  @JsonKey(name: 'key')
  final String token;

  const LoginDataModel({
    required this.token,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);
}
