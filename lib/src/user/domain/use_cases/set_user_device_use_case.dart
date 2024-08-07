import 'dart:developer';

import 'package:flutter_base/src/notifications/domain/interfaces/i_notifications_service.dart';
import 'package:flutter_base/src/user/domain/enums/user_device_type.dart';
import 'package:flutter_base/src/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/src/user/domain/models/device_input_model.dart';
import 'package:injectable/injectable.dart';

class SetUserDeviceUseCaseInput {
  final UserDeviceType type;

  const SetUserDeviceUseCaseInput({
    required this.type,
  });
}

@Injectable()
class SetUserDeviceUseCase {
  final INotificationsService _notificationsService;
  final IUserRepository _userRepository;

  SetUserDeviceUseCase(this._notificationsService, this._userRepository);

  Future<void> call(SetUserDeviceUseCaseInput input) async {
    final deviceToken = await _notificationsService.getToken();
    log('$runtimeType - deviceToken $deviceToken');
    if (deviceToken == null) return;
    if (deviceToken.isNotEmpty) {
      final repoInput = DeviceInputModel(
        tokenId: deviceToken,
        type: input.type,
      );
      await _userRepository.device(repoInput);
    }
  }
}
