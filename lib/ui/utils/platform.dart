import 'package:flutter_base/core/user/domain/enums/user_device_type.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';

final deviceType = PlatformUtils.isIOS ? UserDeviceType.ios : _androidDevice;

final _androidDevice =
    PlatformUtils.isAndroid ? UserDeviceType.android : UserDeviceType.unknown;
