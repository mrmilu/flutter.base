import 'package:flutter_base/src/shared/presentation/utils/platform_utils.dart';
import 'package:flutter_base/src/user/domain/enums/user_device_type.dart';

class DeviceType {
  static UserDeviceType get deviceType => PlatformUtils.isIOS
      ? UserDeviceType.ios
      : PlatformUtils.isAndroid
          ? UserDeviceType.android
          : UserDeviceType.unknown;
}
