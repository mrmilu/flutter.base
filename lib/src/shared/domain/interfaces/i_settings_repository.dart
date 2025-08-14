import '../../presentation/helpers/resource.dart';
import '../failures/endpoints/general_base_failure.dart';
import '../models/app_settings_model.dart';

abstract class ISettingsRepository {
  Future<Resource<GeneralBaseFailure, AppSettingsModel>> getAppSettings();
}
