import 'dart:io';

import 'package:flutter_base/core/user/domain/enums/user_device_type.dart';

final deviceType = Platform.isIOS ? UserDeviceType.ios : _androidDevice;

final _androidDevice =
    Platform.isAndroid ? UserDeviceType.android : UserDeviceType.unknown;
