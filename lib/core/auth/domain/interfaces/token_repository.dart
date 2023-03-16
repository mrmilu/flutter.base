import 'package:flutter_base/core/auth/domain/models/token_model.dart';

abstract class ITokenRepository {
  Future<void> update(TokenModel token);
  Future<void> clear();
  Future<String> getToken();
  Stream<String> getTokenStream();
  void dispose();
}
