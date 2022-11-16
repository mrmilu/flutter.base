import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';
// ignore: unused_import
import 'package:injectable/injectable.dart';

// @Singleton(as: IDeepLinkService)
class DeepLinkService implements IDeepLinkService {
  @override
  Stream<Uri> onLink() {
    return FirebaseDynamicLinks.instance.onLink
        .map((pendingLinkData) => pendingLinkData.link);
  }

  @override
  Future<Uri?> getInitialLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    return initialLink?.link;
  }
}
