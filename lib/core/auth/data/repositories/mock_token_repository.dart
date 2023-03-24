import 'dart:async';

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITokenRepository, env: localEnvironment)
class MockTokenRepository implements ITokenRepository {
  final _controller = StreamController<String>();

  final _faker = Faker.instance;

  @override
  Future<void> clear() async {
    _controller.add('');
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<String> getToken() async {
    return _faker.datatype.uuid();
  }

  @override
  Future<void> update(TokenModel token) async {
    _controller.add(token.token);
    await Future.delayed(const Duration(milliseconds: 100));
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
