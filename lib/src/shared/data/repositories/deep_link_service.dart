import 'package:flutter_base/src/shared/domain/interfaces/i_deep_link_service.dart';

class DeepLinkService implements IDeepLinkService {
  @override
  Stream<Uri> onLink() {
    return const Stream.empty();
  }

  @override
  Future<Uri?> getInitialLink() async {
    return Uri();
  }
}
