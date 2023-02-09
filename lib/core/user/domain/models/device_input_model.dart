import 'package:flutter_base/core/user/domain/enums/user_device_type.dart';

class DeviceInputModel {
  final String tokenId;
  final UserDeviceType type;

  const DeviceInputModel({
    required this.tokenId,
    required this.type,
  });
}
