import 'dart:io';

import 'package:flutter_base/core/user/domain/enums/user_device_type.dart';

final deviceType = Platform.isIOS
    ? UserDeviceType.ios
    : Platform.isAndroid
        ? UserDeviceType.android
        : UserDeviceType.unknown;
