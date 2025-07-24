import 'package:flutter/widgets.dart';

class AppRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = route.settings.name;

    if (screenName != null) {
      // GetIt.I.getAsync<IAnalyticsService>().then((service) {
      //   service.logPageView(screenName: screenName);
      // });
    }
  }
}
