import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> read({required String key}) async {
    return await storage.read(key: key) ?? '';
  }

  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteKey(String key) async {
    await storage.delete(key: key);
  }
}
