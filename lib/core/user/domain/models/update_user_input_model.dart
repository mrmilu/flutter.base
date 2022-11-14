import 'package:json_annotation/json_annotation.dart';

part 'update_user_input_model.g.dart';

@JsonSerializable()
class UpdateUserInputModel {
  final String? name;

  const UpdateUserInputModel({this.name});

  factory UpdateUserInputModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserInputModelToJson(this);
}
