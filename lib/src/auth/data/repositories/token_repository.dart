import 'dart:async';

import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/auth/domain/models/token_model.dart';
import 'package:flutter_base/src/shared/data/repositories/secure_storage_service.dart';
import 'package:flutter_base/src/shared/domain/models/environments_list.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITokenRepository, env: onlineEnvironment)
class TokenRepository implements ITokenRepository {
  final _controller = StreamController<String>();

  final SecureStorageService _secureStorageService;
  final String _tokenKey = 'token';

  TokenRepository(this._secureStorageService);

  @override
  Future<void> clear() async {
    _controller.add('');
    await _secureStorageService.deleteKey(_tokenKey);
  }

  @override
  Future<String> getToken() async {
    return _secureStorageService.read(key: _tokenKey);
  }

  @override
  Future<void> update(TokenModel token) async {
    _controller.add(token.token);
    await _secureStorageService.write(
      key: _tokenKey,
      value: token.token,
    );
  }

  @override
  Stream<String> getTokenStream() async* {
    yield await getToken();
    yield* _controller.stream;
  }

  @override
  @disposeMethod
  void dispose() => _controller.close();
}
