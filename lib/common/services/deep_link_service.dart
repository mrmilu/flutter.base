import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';

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
