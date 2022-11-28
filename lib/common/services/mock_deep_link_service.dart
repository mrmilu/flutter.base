import 'package:flutter_base/common/interfaces/deep_link_service.dart';
import 'package:flutter_base/core/app/domain/models/enviroments_list.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IDeepLinkService, env: localEnviroment)
class MockDeepLinkService implements IDeepLinkService {
  @override
  Stream<Uri> onLink() {
    return Stream.value(Uri());
  }

  @override
  Future<Uri?> getInitialLink() async {
    return Future.value(Uri());
  }
}
