enum UserStatusType {
  active,
  inactive,
  suspended;

  const UserStatusType();

  R map<R>({
    required R Function() active,
    required R Function() inactive,
    required R Function() suspended,
  }) {
    switch (this) {
      case UserStatusType.active:
        return active();
      case UserStatusType.inactive:
        return inactive();
      case UserStatusType.suspended:
        return suspended();
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserStatusType.active:
        return 'ACTIVE';
      case UserStatusType.inactive:
        return 'INACTIVE';
      case UserStatusType.suspended:
        return 'SUSPENDED';
    }
  }

  static UserStatusType fromString(String status) {
    switch (status) {
      case 'ACTIVE':
        return UserStatusType.active;
      case 'INACTIVE':
        return UserStatusType.inactive;
      case 'SUSPENDED':
        return UserStatusType.suspended;
      default:
        return UserStatusType.inactive;
    }
  }
}
