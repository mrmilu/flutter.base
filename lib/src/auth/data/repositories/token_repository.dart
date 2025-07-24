import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../domain/interfaces/i_token_repository.dart';
import 'secure_storage_service.dart';

class TokenRepositoryImpl implements ITokenRepository {
  final SecureStorageService _secureStorageService;
  final Dio _httpClient;
  final String _tokenKey = 'token';
  final String _refreshToken = 'refreshToken';

  TokenRepositoryImpl(this._secureStorageService, this._httpClient);

  @override
  Future<void> clear() async {
    await _secureStorageService.deleteKey(_tokenKey);
    await _secureStorageService.deleteKey(_refreshToken);
  }

  @override
  Future<String?> getToken() async {
    try {
      final token = await _secureStorageService.storage.read(key: _tokenKey);
      return token;
    } catch (e, _) {
      await _secureStorageService.storage.delete(key: _tokenKey);
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final token = await _secureStorageService.storage.read(
        key: _refreshToken,
      );
      return token;
    } catch (e, _) {
      await _secureStorageService.storage.delete(key: _refreshToken);
      return null;
    }
  }

  @override
  Future<void> saveTokens({
    required String token,
    String? refreshToken,
  }) async {
    await _secureStorageService.storage.write(
      key: _tokenKey,
      value: token,
    );
    await _secureStorageService.storage.write(
      key: _refreshToken,
      value: refreshToken,
    );
  }

  @override
  Future<String?> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return null;

      final response = await _httpClient.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        final newRefreshToken = response.data['refresh_token'];

        await saveTokens(
          token: newToken,
          refreshToken: newRefreshToken,
        );
        return newToken;
      }
      return null;
    } catch (e) {
      log('Error refreshing token: $e');
      return null;
    }
  }

  @override
  Future<Map<String, String>?> getEmailAndPassword() async {
    try {
      final email = await _secureStorageService.storage.read(key: 'email');
      final password = await _secureStorageService.storage.read(
        key: 'password',
      );
      if (email != null && password != null) {
        return {'email': email, 'password': password};
      }
      return null;
    } catch (e) {
      log('Error getting email and password: $e');
      return null;
    }
  }

  @override
  Future<void> saveEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _secureStorageService.storage.write(key: 'email', value: email);
    await _secureStorageService.storage.write(key: 'password', value: password);
  }

  @override
  Future<void> clearEmailAndPassword() async {
    await _secureStorageService.storage.delete(key: 'email');
    await _secureStorageService.storage.delete(key: 'password');
  }

  @override
  Future<void> savePassword(String password) async {
    await _secureStorageService.storage.write(key: 'password', value: password);
  }
}
