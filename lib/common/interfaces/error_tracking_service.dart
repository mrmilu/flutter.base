import 'package:flutter_base/common/services/error_tracking_service.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@Injectable(as: IErrorTrackingService, env: onlineEnvironment)
class ErrorTrackingService implements IErrorTrackingService {
  @override
  Future<void> setUser(ErrorTrackingUser user) async {
    await _setSentryUser(
      SentryUser(
        email: user.email,
        id: user.id,
        name: user.name,
        username: user.username,
      ),
    );
  }

  @override
  Future<void> logout() async {
    await _setSentryUser(null);
  }

  @override
  Future<void> setTag(String key, String value) async {
    await Sentry.configureScope((scope) => scope.setTag(key, value));
  }

  @override
  Future<void> setTags(Map<String, String> tags) async {
    await Sentry.configureScope(
      (scope) => Future.wait(
        tags.entries.map((entry) => scope.setTag(entry.key, entry.value)),
      ),
    );
  }

  Future<void> _setSentryUser(SentryUser? user) async {
    await Sentry.configureScope((scope) => scope.setUser(user));
  }
}
