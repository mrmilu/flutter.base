import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserUseCase {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  Future<User> call() async {
    return _userRepository.getLoggedUser();
  }
}
