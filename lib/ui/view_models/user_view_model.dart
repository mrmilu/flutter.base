import 'package:flutter_base/core/user/domain/models/user.dart';

class UserViewModel extends User {
  UserViewModel({
    super.id,
    required super.email,
    required super.name,
    super.verified,
  });

  UserViewModel copyWith({
    int? id,
    String? email,
    String? name,
    bool? verified,
  }) {
    return UserViewModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      verified: verified ?? this.verified,
    );
  }
}

extension ToViewModel on User {
  UserViewModel toViewModel() {
    return UserViewModel(
      id: id,
      email: email,
      name: name,
      verified: verified,
    );
  }
}
