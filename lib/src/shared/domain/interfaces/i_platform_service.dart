import 'package:flutter_base/src/shared/domain/models/platform_info.dart';

abstract class IPlatformService {
  Future<PlatformInfo> getInfo();
}
