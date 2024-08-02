import 'package:flutter_base/src/user/domain/models/device_input_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_output_model.g.dart';

@JsonSerializable(createFactory: false)
class DeviceOutputModel {
  @JsonKey(name: 'registration_id')
  final String registrationId;
  final String type;

  const DeviceOutputModel({
    required this.registrationId,
    required this.type,
  });

  Map<String, dynamic> toJson() => _$DeviceOutputModelToJson(this);
}

extension ToOutput on DeviceInputModel {
  DeviceOutputModel toOutput() {
    return DeviceOutputModel(
      registrationId: tokenId,
      type: type.name,
    );
  }
}
