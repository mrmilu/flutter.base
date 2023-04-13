import 'package:flutter_base/core/app/domain/models/platform_info.dart';

abstract class IPlatformService {
  Future<PlatformInfo> getInfo();
}
