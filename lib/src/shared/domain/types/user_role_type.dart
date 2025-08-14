enum UserRoleType {
  admin,
  user;

  const UserRoleType();

  R map<R>({
    required R Function() admin,
    required R Function() user,
  }) {
    switch (this) {
      case UserRoleType.admin:
        return admin();
      case UserRoleType.user:
        return user();
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserRoleType.admin:
        return 'ADMIN';
      case UserRoleType.user:
        return 'USER';
    }
  }

  static UserRoleType fromString(String status) {
    switch (status) {
      case 'ADMIN':
        return UserRoleType.admin;
      case 'USER':
        return UserRoleType.user;
      default:
        return UserRoleType.user;
    }
  }
}
