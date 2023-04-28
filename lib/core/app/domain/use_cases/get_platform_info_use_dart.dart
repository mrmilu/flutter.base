import 'package:flutter_base/common/interfaces/platform_service.dart';
import 'package:flutter_base/core/app/domain/models/platform_info.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlatformUseCase {
  final IPlatformService _platformService;

  const GetPlatformUseCase(this._platformService);

  Future<PlatformInfo> call() async {
    return _platformService.getInfo();
  }
}
