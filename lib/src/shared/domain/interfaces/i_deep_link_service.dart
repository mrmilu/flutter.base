abstract class IDeepLinkService {
  Stream<Uri> onLink();

  Future<Uri?> getInitialLink();
}
