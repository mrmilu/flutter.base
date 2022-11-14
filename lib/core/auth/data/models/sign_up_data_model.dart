import 'package:json_annotation/json_annotation.dart';

part 'sign_up_data_model.g.dart';

@JsonSerializable(createToJson: false)
class SignUpDataModel {
  @JsonKey(required: true, name: "key")
  String token;

  SignUpDataModel({
    required this.token,
  });

  factory SignUpDataModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpDataModelFromJson(json);
}
