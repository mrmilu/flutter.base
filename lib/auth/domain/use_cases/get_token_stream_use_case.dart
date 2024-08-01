import 'package:flutter_base/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTokenStreamUseCase {
  final tokenRepository = getIt<ITokenRepository>();

  Stream<String> call() {
    return tokenRepository.getTokenStream();
  }
}
