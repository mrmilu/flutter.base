import 'package:injectable/injectable.dart';

@Injectable()
class InitAppUseCase {
  InitAppUseCase();

  Future call() async {
    await Future.wait([]);
  }
}
