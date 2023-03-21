import 'package:flutter_base/common/services/secure_storage_service.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ITokenRepository, env: onlineEnvironment)
class TokenRepository implements ITokenRepository {
  final SecureStorageService _secureStorageService;

  final String _tokenKey = 'token';

  TokenRepository(this._secureStorageService);

  @override
  Future<void> clear() async {
    await _secureStorageService.deleteKey(_tokenKey);
  }

  @override
  Future<String> getToken() {
    return _secureStorageService.read(key: _tokenKey);
  }

  @override
  Future<void> update(TokenModel token) async {
    await _secureStorageService.write(
      key: _tokenKey,
      value: token.token,
    );
  }
}
