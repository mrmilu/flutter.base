import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:get_it/get_it.dart';

String buildFileUrl(String filename) {
  return '${GetIt.I.get<IEnvVars>().apiUrl}/file/$filename';
}
