import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_output_model.g.dart';

@JsonSerializable(createFactory: false)
class UpdateUserOutputModel {
  final String? name;

  const UpdateUserOutputModel({this.name});

  Map<String, dynamic> toJson() => _$UpdateUserOutputModelToJson(this);
}

extension ToOutput on UpdateUserInputModel {
  UpdateUserOutputModel toOutput() {
    return UpdateUserOutputModel(name: name);
  }
}
