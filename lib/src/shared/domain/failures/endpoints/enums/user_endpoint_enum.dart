enum UserEndpointType {
  userNotFound,
  userInvalid,
  general;

  String get defaultMessage {
    switch (this) {
      case UserEndpointType.userNotFound:
        return 'Usuario no encontrado.';
      case UserEndpointType.userInvalid:
        return 'Usuario inválido.';
      case UserEndpointType.general:
        return 'Error general.';
    }
  }

  R when<R>({
    required R Function() userNotFound,
    required R Function() userInvalid,
    required R Function() general,
  }) {
    switch (this) {
      case UserEndpointType.userNotFound:
        return userNotFound();
      case UserEndpointType.userInvalid:
        return userInvalid();
      case UserEndpointType.general:
        return general();
    }
  }

  R map<R>({
    required R Function() userNotFound,
    required R Function() userInvalid,
    required R Function() general,
  }) {
    switch (this) {
      case UserEndpointType.userNotFound:
        return userNotFound();
      case UserEndpointType.userInvalid:
        return userInvalid();
      case UserEndpointType.general:
        return general();
    }
  }

  static UserEndpointType fromString(String value, String message) {
    switch (value) {
      case 'userNotFound':
        return UserEndpointType.userNotFound;
      case 'userInvalid':
        return UserEndpointType.userInvalid;
      case 'general':
        return UserEndpointType.general;
      default:
        return UserEndpointType.general;
    }
  }
}
