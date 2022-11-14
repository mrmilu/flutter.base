import 'package:injectable/injectable.dart';
import 'package:flutter_base/common/services/secure_storage_service.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';

@Injectable(as: ITokenRepository)
class TokenRepository implements ITokenRepository {
  final SecureStorageService _secureStorageService;

  TokenRepository(this._secureStorageService);

  final String _tokenKey = 'token';

  @override
  Future<void> clear() async {
    await _secureStorageService.deleteKey(_tokenKey);
  }

  @override
  Future<String> getToken() async {
    return await _secureStorageService.read(key: _tokenKey);
  }

  @override
  Future<void> update(TokenModel token) async {
    await _secureStorageService.write(
      key: _tokenKey,
      value: token.token,
    );
  }
}
