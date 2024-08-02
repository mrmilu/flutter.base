import 'package:flutter_base/src/user/domain/enums/user_device_type.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';

class DeviceType {
  static UserDeviceType get deviceType => PlatformUtils.isIOS
      ? UserDeviceType.ios
      : PlatformUtils.isAndroid
          ? UserDeviceType.android
          : UserDeviceType.unknown;
}
