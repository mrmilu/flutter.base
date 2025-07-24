abstract class UserRoleType {
  const UserRoleType();
  factory UserRoleType.admin() = UserRoleTypeAdmin;
  factory UserRoleType.user() = UserRoleTypeUser;

  void when({
    required void Function(UserRoleTypeAdmin) admin,
    required void Function(UserRoleTypeUser) user,
  }) {
    if (this is UserRoleTypeAdmin) {
      admin.call(this as UserRoleTypeAdmin);
    }

    if (this is UserRoleTypeUser) {
      user.call(this as UserRoleTypeUser);
    }

    admin.call(this as UserRoleTypeAdmin);
  }

  R map<R>({
    required R Function(UserRoleTypeAdmin) admin,
    required R Function(UserRoleTypeUser) user,
  }) {
    if (this is UserRoleTypeAdmin) {
      return admin.call(this as UserRoleTypeAdmin);
    }

    if (this is UserRoleTypeUser) {
      return user.call(this as UserRoleTypeUser);
    }

    return admin.call(this as UserRoleTypeAdmin);
  }

  void maybeWhen({
    void Function(UserRoleTypeAdmin)? admin,
    void Function(UserRoleTypeUser)? user,
    required void Function() orElse,
  }) {
    if (this is UserRoleTypeAdmin && admin != null) {
      admin.call(this as UserRoleTypeAdmin);
    }

    if (this is UserRoleTypeUser && user != null) {
      user.call(this as UserRoleTypeUser);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(UserRoleTypeAdmin)? admin,
    R Function(UserRoleTypeUser)? user,
    required R Function() orElse,
  }) {
    if (this is UserRoleTypeAdmin && admin != null) {
      return admin.call(this as UserRoleTypeAdmin);
    }

    if (this is UserRoleTypeUser && user != null) {
      return user.call(this as UserRoleTypeUser);
    }

    return orElse.call();
  }

  factory UserRoleType.fromString(String value) {
    if (value == 'ADMIN') {
      return UserRoleType.admin();
    }

    if (value == 'USER') {
      return UserRoleType.user();
    }

    return UserRoleType.admin();
  }

  @override
  String toString() {
    if (this is UserRoleTypeAdmin) {
      return 'ADMIN';
    }

    if (this is UserRoleTypeUser) {
      return 'USER';
    }

    return 'ADMIN';
  }
}

class UserRoleTypeAdmin extends UserRoleType {}

class UserRoleTypeUser extends UserRoleType {}
