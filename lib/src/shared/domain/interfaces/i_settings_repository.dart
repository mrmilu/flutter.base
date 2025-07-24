import '../../helpers/resource.dart';
import '../failures/firebase_failure.dart';
import '../models/app_settings_model.dart';

abstract class ISettingsRepository {
  Future<Resource<FirebaseFailure, AppSettingsModel>> getAppSettings();
}
