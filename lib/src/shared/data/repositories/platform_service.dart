import 'package:flutter_base/src/shared/domain/interfaces/i_platform_service.dart';
import 'package:flutter_base/src/shared/domain/models/platform_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PlatformService implements IPlatformService {
  @override
  Future<PlatformInfo> getInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return PlatformInfo(
      appName: packageInfo.appName,
      buildNumber: packageInfo.buildNumber,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
    );
  }
}
