import 'package:flutter_base/src/shared/domain/models/platform_info.dart';
import 'package:flutter_base/src/shared/domain/use_cases/get_platform_info_use_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final infoAppProvider = FutureProvider<PlatformInfo>((ref) async {
  final GetPlatformUseCase getPlatformUseCase =
      GetIt.I.get<GetPlatformUseCase>();
  return getPlatformUseCase();
});
