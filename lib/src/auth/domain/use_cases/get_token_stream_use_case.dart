import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/shared/ioc/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTokenStreamUseCase {
  final tokenRepository = getIt<ITokenRepository>();

  Stream<String> call() {
    return tokenRepository.getTokenStream();
  }
}
