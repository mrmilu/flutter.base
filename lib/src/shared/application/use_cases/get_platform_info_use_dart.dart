import 'package:flutter_base/src/shared/domain/interfaces/i_platform_service.dart';
import 'package:flutter_base/src/shared/domain/models/platform_info.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlatformUseCase {
  final IPlatformService _platformService;

  const GetPlatformUseCase(this._platformService);

  Future<PlatformInfo> call() async {
    return _platformService.getInfo();
  }
}
