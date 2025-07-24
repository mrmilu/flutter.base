import 'dart:convert';

import '../../domain/models/user_model.dart';
import '../../domain/types/document_type.dart';
import '../../domain/types/prefix_phone_type.dart';
import '../../domain/types/user_auth_provider_type.dart';
import '../../domain/types/user_status_type.dart';

class UserDto {
  final String id;
  final String? name;
  final String? lastName;
  final String email;
  final String? contactEmail;
  // prefix_number
  final (String, String)? phone;
  // type_code
  final (String, String)? document;
  final String language;
  final bool isValidated;
  final String authProvider;
  final String status;
  UserDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.contactEmail,
    required this.phone,
    required this.document,
    required this.language,
    required this.isValidated,
    required this.authProvider,
    required this.status,
  });
  UserDto._({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.contactEmail,
    required this.phone,
    required this.document,
    required this.language,
    required this.isValidated,
    required this.authProvider,
    required this.status,
  });

  factory UserDto.fromDomain(UserModel model) {
    return UserDto._(
      id: model.id,
      name: model.name,
      lastName: model.lastName,
      email: model.email,
      contactEmail: model.contactEmail,
      phone: model.phone != null
          ? (model.phone!.$1.prefix, model.phone!.$2)
          : null,
      document: model.document != null
          ? (model.document!.$1.toString(), model.document!.$2)
          : null,
      language: model.language,
      isValidated: model.isValidated,
      authProvider: model.authProvider.toString(),
      status: model.status.toString(),
    );
  }

  UserModel toDomain() {
    return UserModel(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      contactEmail: contactEmail,
      phone: phone != null
          ? (PrefixPhoneType.getByPrefix(phone!.$1), phone!.$2)
          : null,
      document: document != null
          ? (DocumentType.fromString(document!.$1), document!.$2)
          : null,
      language: language,
      isValidated: isValidated,
      authProvider: UserAuthProviderType.fromString(authProvider),
      status: UserStatusType.fromString(status),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'contact_email': contactEmail,
      'phone': phone != null
          ? {
              'prefix': phone?.$1,
              'number': phone?.$2,
            }
          : null,
      'document': document != null
          ? {
              'type': document?.$1.toString(),
              'code': document?.$2,
            }
          : null,
      'language': language,
      'is_validated': isValidated,
      'auth_provider': authProvider,
      'status': status,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] ?? '',
      name: map['name'],
      lastName: map['last_name'],
      email: map['email'] ?? '',
      contactEmail: map['contact_email'],
      phone: map['phone'] != null
          ? (map['phone']['prefix'], map['phone']['number'])
          : null,
      document: map['document'] != null
          ? (map['document']['type'], map['document']['code'])
          : null,
      language: map['language'] ?? 'ES',
      isValidated: map['is_validated'] ?? false,
      authProvider: map['auth_provider'] ?? 'EMAIL',
      status: map['status'] ?? 'NO_CLIENT',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));
}
