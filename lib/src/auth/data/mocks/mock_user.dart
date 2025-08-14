import '../../../shared/domain/models/user_model.dart';
import '../../../shared/domain/types/document_type.dart';
import '../../../shared/domain/types/prefix_phone_type.dart';
import '../../../shared/domain/types/user_auth_provider_type.dart';
import '../../../shared/domain/types/user_status_type.dart';

final mockUser = UserModel(
  id: 'mock-user-id',
  name: 'Mock',
  lastName: 'User',
  imageUrl: null,
  email: 'mock.user@example.com',
  contactEmail: 'mock.user@example.com',
  phone: (PrefixPhoneType.spain, '600123456'),
  document: (DocumentType.nif, '12345678A'),
  language: 'ES',
  isValidated: true,
  authProvider: UserAuthProviderType.email,
  status: UserStatusType.active,
);
