import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../models/app_settings_model.dart';

abstract class ISettingsRepository {
  Future<Resource<GeneralBaseFailure, AppSettingsModel>> getAppSettings();
}
