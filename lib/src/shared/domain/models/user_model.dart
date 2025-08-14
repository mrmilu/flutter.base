import '../../presentation/utils/phone_formatter_utils.dart';
import '../types/document_type.dart';
import '../types/prefix_phone_type.dart';
import '../types/user_auth_provider_type.dart';
import '../types/user_status_type.dart';

class UserModel {
  final String id;
  final String? name;
  final String? lastName;
  final String email;
  final String? contactEmail;
  final String? imageUrl;
  // prefix_number
  final (PrefixPhoneType, String)? phone;
  // type_code
  final (DocumentType, String)? document;
  final String language;
  final bool isValidated;
  final UserAuthProviderType authProvider;
  final UserStatusType status;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.imageUrl,
    required this.email,
    required this.contactEmail,
    required this.phone,
    required this.document,
    required this.language,
    required this.isValidated,
    required this.authProvider,
    required this.status,
  });

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: null,
      lastName: null,
      imageUrl: '',
      email: '',
      contactEmail: null,
      phone: null,
      document: null,
      language: 'ES',
      isValidated: false,
      authProvider: UserAuthProviderType.email,
      status: UserStatusType.active,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    String? imageUrl,
    String? email,
    String? contactEmail,
    (PrefixPhoneType, String)? phone,
    (DocumentType, String)? document,
    String? language,
    bool? isValidated,
    UserAuthProviderType? authProvider,
    UserStatusType? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      contactEmail: contactEmail ?? this.contactEmail,
      phone: phone ?? this.phone,
      document: document ?? this.document,
      language: language ?? this.language,
      isValidated: isValidated ?? this.isValidated,
      authProvider: authProvider ?? this.authProvider,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, lastName: $lastName, imageUrl: $imageUrl, email: $email, contactEmail: $contactEmail, phone: $phone, document: $document, language: $language, isValidated: $isValidated, authProvider: $authProvider, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.imageUrl == imageUrl &&
        other.email == email &&
        other.contactEmail == contactEmail &&
        other.phone == phone &&
        other.document == document &&
        other.language == language &&
        other.isValidated == isValidated &&
        other.authProvider == authProvider &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        imageUrl.hashCode ^
        email.hashCode ^
        contactEmail.hashCode ^
        phone.hashCode ^
        document.hashCode ^
        language.hashCode ^
        isValidated.hashCode ^
        authProvider.hashCode ^
        status.hashCode;
  }

  String get phoneNumberFormatted {
    if (phone == null) return '';
    return PhoneFormatterUtils.formatPhoneNumber(phone!.$2, phone!.$1.mask);
  }
}
