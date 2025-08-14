# Estructura de Features

## Introducción

Este documento describe cómo están organizadas las funcionalidades (features) en Flutter Base, siguiendo los principios de **Vertical Slice Architecture** y **Clean Architecture**.

## Tabla de Contenidos

- [Conceptos Fundamentales](#conceptos-fundamentales)
- [Estructura de Carpetas](#estructura-de-carpetas)
- [Capa de Datos (Data)](#capa-de-datos-data)
- [Capa de Dominio (Domain)](#capa-de-dominio-domain)
- [Capa de Presentación (Presentation)](#capa-de-presentación-presentation)
- [Shared vs Feature-Specific](#shared-vs-feature-specific)
- [Ejemplos Prácticos](#ejemplos-prácticos)

## Conceptos Fundamentales

### Vertical Slice Architecture

Cada feature es un "corte vertical" que contiene todas las capas necesarias para su funcionamiento:

```
Feature = Data + Domain + Presentation
```

### Principios de Clean Architecture

1. **Independencia**: Cada capa puede funcionar independientemente
2. **Inversión de dependencias**: Las capas externas dependen de las internas
3. **Testabilidad**: Cada capa puede ser probada por separado
4. **Separación de responsabilidades**: Cada capa tiene un propósito específico

## Estructura de Carpetas

### Estructura General de un Feature

```
feature_name/
├── data/                 # Capa de datos (más externa)
│   ├── dtos/             # Data Transfer Objects
│   ├── mocks/            # Datos mock para testing
│   ├── repositories/     # Implementaciones de repositorios
│   └── services/         # Servicios específicos del feature
├── domain/               # Capa de dominio (más interna)
│   ├── failures/         # Tipos de errores específicos
│   ├── interfaces/       # Interfaces de repositorios y servicios
│   ├── models/           # Modelos de dominio
│   ├── types/            # Tipos y enums del dominio
│   └── vos/              # Value Objects (objetos de valor)
└── presentation/         # Capa de presentación (externa)
    ├── extensions/       # Extensiones
    ├── pages/            # Páginas/pantallas
    ├── providers/        # Gestión de estado (BLoC, Provider, etc.)
    └── widgets/          # Widgets específicos del feature
```

**Nota sobre Use Cases**: Este proyecto no implementa una capa de Application/Use Cases separada. La lógica de negocio se maneja directamente en los providers de la capa de presentación, manteniendo una arquitectura más simple pero efectiva.

### Features Existentes en el Proyecto

```
src/
├── auth/                  # Autenticación y autorización
├── home/                  # Pantalla principal
├── settings/              # Configuraciones de usuario
├── splash/                # Pantalla de carga inicial
├── tap2/                  # Feature específico del negocio
├── locale/                # Gestión de idiomas
└── shared/                # Código compartido entre features
```

## Capa de Datos (Data)

La capa más externa, responsable de obtener y almacenar datos.

### DTOs (Data Transfer Objects)

**Propósito**: Representar datos tal como vienen/van a fuentes externas (APIs, bases de datos)

```dart
// shared/data/dtos/user_dto.dart
class UserDto {
  final String id;
  final String? name;
  final String? lastName;
  final String? imageUrl;
  final String email;
  final String? contactEmail;
  final (String, String)? phone;      // (prefix, number) como strings
  final (String, String)? document;   // (type, code) como strings
  final String language;
  final bool isValidated;
  final String authProvider;          // String raw del API
  final String status;                // String raw del API

  UserDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.authProvider,
    required this.status,
    // ... otros campos
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      authProvider: json['auth_provider'] as String,
      status: json['status'] as String,
      // ... mapeo directo del JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'auth_provider': authProvider,
      'status': status,
      // ... serialización directa
    };
  }

  // Conversión a modelo de dominio
  UserModel toDomain() {
    return UserModel(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      phone: phone != null 
          ? (PrefixPhoneType.fromString(phone!.$1), phone!.$2)
          : null,
      document: document != null
          ? (DocumentType.fromString(document!.$1), document!.$2)
          : null,
      authProvider: UserAuthProviderType.fromString(authProvider),
      status: UserStatusType.fromString(status),
      // ... conversión con validaciones y tipos tipados
    );
  }
}
```

### Mocks

**Propósito**: Datos simulados para testing y desarrollo

```dart
// auth/data/mocks/mock_user.dart
class MockUser {
  static const userBase = {
    'id': '1',
    'email': 'test@example.com',
    'fullname': 'Test User',
    'status': 'active',
    'authProvider': 'email',
    'role': 'user',
  };

  static const userToken = 'mock_jwt_token_here';
}
```

### Repositories

**Propósito**: Implementar las interfaces de repositorio definidas en domain/interfaces

```dart
// auth/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseSocialAuthService _firebaseAuthService;
  final TokenRepository _tokenRepository;
  final SecureStorageService _secureStorage;

  AuthRepositoryImpl(
    this._firebaseAuthService,
    this._tokenRepository,
    this._secureStorage,
  );

  @override
  Future<ResultOr<SignInFailure>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Obtener datos del usuario desde API
      final userDto = await _apiService.getUser(userCredential.user!.uid);
      
      // Convertir DTO a modelo de dominio
      final userModel = userDto.toDomain();
      
      // Guardar token
      await _tokenRepository.saveToken(userCredential.user!.accessToken);
      
      return success();
    } on FirebaseAuthException catch (e) {
      return failure(SignInFailure.fromFirebaseError(e));
    } catch (e) {
      return failure(SignInFailure.unknown());
    }
  }
}
```

### Services

**Propósito**: Servicios específicos del feature para lógica de datos compleja

```dart
// auth/data/services/firebase_social_auth_service.dart
class FirebaseSocialAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    if (googleUser == null) {
      throw Exception('Google sign in aborted');
    }

    final GoogleSignInAuthentication googleAuth = 
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }
}
```

## Capa de Dominio (Domain)

La capa más interna, contiene la lógica de negocio pura.

### Interfaces

**Propósito**: Definir contratos para repositorios y servicios (abstracciones)

```dart
// auth/domain/interfaces/i_auth_repository.dart
abstract class IAuthRepository {
  Future<ResultOr<SignInFailure>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<void> logout();
  
  Future<ResultOr<SignUpFailure>> signUp({
    required String email,
    required String password,
  });
  
  Future<UserModel?> getUser();
  
  Future<ResultOr<OAuthSignInFailure>> signInWithFacebook();
  Future<ResultOr<OAuthSignInFailure>> signInWithGoogle();
  Future<ResultOr<OAuthSignInFailure>> signInWithApple();
}
```

### Models

**Propósito**: Representar objetos de negocio del dominio

```dart
// shared/domain/models/user_model.dart
class UserModel {
  final String id;
  final String? name;
  final String? lastName;
  final String email;
  final String? contactEmail;
  final String? imageUrl;
  final (PrefixPhoneType, String)? phone;
  final (DocumentType, String)? document;
  final String language;
  final bool isValidated;
  final UserAuthProviderType authProvider;
  final UserStatusType status;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.authProvider,
    required this.status,
    // ... otros campos
  });

  // Métodos de copia, serialización, etc.
}
```

### Value Objects (VOs)

**Propósito**: Objetos inmutables que encapsulan validaciones de dominio

```dart
// shared/domain/vos/email_vos.dart
class EmailVos extends ValueObject<EmailFailure, String> {
  @override
  final Either<EmailFailure, String> value;

  factory EmailVos(String input) {
    return EmailVos._(_validate(input.trim()));
  }
  
  const EmailVos._(this.value);

  static Either<EmailFailure, String> _validate(String input) {
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    if (input.isEmpty) {
      return left(EmailFailure.empty());
    }

    if (!RegExp(emailRegex).hasMatch(input)) {
      return left(EmailFailure.invalid());
    }

    return right(input);
  }
}
```

### Types

**Propósito**: Enums y tipos específicos del dominio

```dart
// shared/domain/types/user_status_type.dart
enum UserStatusType {
  active('active'),
  inactive('inactive'),
  pending('pending'),
  suspended('suspended');

  const UserStatusType(this.value);
  final String value;

  static UserStatusType fromString(String value) {
    return UserStatusType.values.firstWhere(
      (status) => status.value == value,
      orElse: () => UserStatusType.pending,
    );
  }
}
```

### Failures

**Propósito**: Definir tipos de errores específicos del dominio usando patrón de sealed classes

```dart
// auth/domain/failures/signin_failure.dart
abstract class SignInFailure {
  const SignInFailure();
  
  // Factory constructors para cada tipo de error
  factory SignInFailure.nonExistentUserWithEmailAndPassword() = 
      NonExistentUserAndPassword;
  factory SignInFailure.serverError() = ServerError;
  
  // Factory desde string (útil para serialización)
  factory SignInFailure.fromString(String value) {
    if (value == 'nonExistentUserWithEmailAndPassword') {
      return SignInFailure.nonExistentUserWithEmailAndPassword();
    }
    if (value == 'serverError') {
      return SignInFailure.serverError();
    }
    return SignInFailure.nonExistentUserWithEmailAndPassword();
  }

  // Pattern matching con when
  void when({
    required void Function(NonExistentUserAndPassword) 
        nonExistentUserWithEmailAndPassword,
    required void Function(ServerError) serverError,
  }) {
    if (this is NonExistentUserAndPassword) {
      nonExistentUserWithEmailAndPassword(this as NonExistentUserAndPassword);
    }
    if (this is ServerError) {
      serverError(this as ServerError);
    }
  }

  // Pattern matching con map (retorna valor)
  R map<R>({
    required R Function(NonExistentUserAndPassword) 
        nonExistentUserWithEmailAndPassword,
    required R Function(ServerError) serverError,
  }) {
    if (this is NonExistentUserAndPassword) {
      return nonExistentUserWithEmailAndPassword(this as NonExistentUserAndPassword);
    }
    if (this is ServerError) {
      return serverError(this as ServerError);
    }
    return nonExistentUserWithEmailAndPassword(this as NonExistentUserAndPassword);
  }

  @override
  String toString() {
    if (this is NonExistentUserAndPassword) {
      return 'nonExistentUserWithEmailAndPassword';
    }
    if (this is ServerError) {
      return 'serverError';
    }
    return 'nonExistentUserWithEmailAndPassword';
  }
}

// Implementaciones concretas
class NonExistentUserAndPassword extends SignInFailure {}
class ServerError extends SignInFailure {}
```

**Uso en código:**
```dart
// En repository
Future<ResultOr<SignInFailure>> signIn() async {
  try {
    // ... lógica de autenticación
    return success();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return failure(SignInFailure.nonExistentUserWithEmailAndPassword());
    }
    return failure(SignInFailure.serverError());
  }
}

// En Cubit/Provider
final result = await authRepository.signIn();
result.fold(
  (failure) {
    failure.when(
      nonExistentUserWithEmailAndPassword: (_) {
        emit(state.copyWith(errorMessage: 'Usuario no encontrado'));
      },
      serverError: (_) {
        emit(state.copyWith(errorMessage: 'Error del servidor'));
      },
    );
  },
  (success) => initUser(),
);
```
```

### Failures Extensions

**Propósito**: Extensiones para manejo de errores específicos

```dart
// shared/presentation/extensions/failures_extensions/email_failure_extension.dart
extension EmailFailureExtension on EmailFailure {
  String get message {
    switch (runtimeType) {
      case EmailFailureEmpty:
        return 'Email is required';
      case EmailFailureInvalid:
        return 'Please enter a valid email address';
      default:
        return 'Invalid email';
    }
  }
}

## Capa de Presentación (Presentation)

La capa que interactúa con el usuario y maneja la lógica de presentación.

### Pages

**Propósito**: Pantallas completas de la aplicación

```dart
// auth/presentation/pages/login_page.dart
class LoginPage extends StatelessWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.cl.translate('auth.login.title')),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SignInPage(), // Widget específico del feature
        ),
      ),
    );
  }
}
```

### Providers

**Propósito**: Gestionar estado usando BLoC pattern (Cubit)

```dart
// auth/presentation/providers/auth/auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;
  
  AuthCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(AuthState.initial());

  Future<void> initUser() async {
    final user = await authRepository.getUser();
    if (user != null) {
      if (user.document != null) {
        createTokenDevice();
      }
      await MyAnalyticsHelper.setUserId(user.id);
      await Sentry.configureScope((scope) => scope.setUser(
        SentryUser(id: user.id, email: user.email),
      ));
      emit(state.copyWith(user: user));
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    globalLoaderCubit.showLoader();
    
    final result = await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    result.fold(
      (failure) {
        emit(state.copyWith(signInFailure: failure));
      },
      (success) {
        initUser();
      },
    );
    
    globalLoaderCubit.hideLoader();
  }
}

// auth/presentation/providers/auth/auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    SignInFailure? signInFailure,
    SignUpFailure? signUpFailure,
    // ... otros campos de estado
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}
```

### Feature-Specific Folders

**Propósito**: Organizar componentes específicos por funcionalidad

```
auth/presentation/
├── signin/                # Todo lo relacionado con Sign In
│   ├── providers/         # Providers específicos de Sign In
│   └── sign_in_page.dart  # Página principal de Sign In
├── signup/                # Todo lo relacionado con Sign Up
│   ├── providers/         # Providers específicos de Sign Up
│   └── sign_up_page.dart  # Página principal de Sign Up
├── pages/                 # Páginas generales del feature
├── providers/             # Providers compartidos del feature
└── widgets/               # Widgets reutilizables del feature
```

### Widgets

**Propósito**: Componentes UI reutilizables específicos del feature

```dart
// auth/presentation/widgets/social_login_buttons_widget.dart
class SocialLoginButtonsWidget extends StatelessWidget {
  const SocialLoginButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButtonWidget(
          onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
          icon: SvgPicture.asset('assets/icons/logo_google.svg'),
          label: context.cl.translate('auth.signInWithGoogle'),
        ),
        const SizedBox(height: 12),
        CustomElevatedButtonWidget(
          onPressed: () => context.read<AuthCubit>().signInWithApple(),
          icon: SvgPicture.asset('assets/icons/logo_apple.svg'),
          label: context.cl.translate('auth.signInWithApple'),
        ),
      ],
    );
  }
}
```

**Integración con manejo de errores:**
```dart
// Widget con manejo de estado y errores
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state.signInFailure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.signInFailure!.message),
          backgroundColor: context.appTheme.colorScheme.error,
        ),
      );
    }
  },
  child: YourWidget(),
)
```
```

## Shared vs Feature-Specific

### Código Compartido (shared/)

Se encuentra en `src/shared/` y contiene código reutilizable entre features:

```
shared/
├── data/
│   ├── dtos/              # Data Transfer Objects compartidos
│   ├── repositories/      # Implementaciones de repositorios globales
│   └── services/          # Servicios globales (HTTP, Push, Analytics)
├── domain/
│   ├── failures/          # Tipos de errores base
│   ├── interfaces/        # Interfaces compartidas
│   ├── models/            # Modelos de dominio compartidos
│   ├── types/             # Enums y tipos globales
│   └── vos/               # Value Objects reutilizables
├── helpers/               # Funciones de utilidad y helpers
└── presentation/
    ├── l10n/             # Internacionalización
    ├── extensions/       # Extensiones para errores
    ├── pages/            # Páginas globales
    ├── providers/        # Providers globales (tema, loader, etc.)
    ├── router/           # Configuración de navegación
    ├── utils/            # Utilidades de UI
    └── widgets/          # Widgets reutilizables globales
```

**Ejemplos de contenido compartido:**

```dart
// shared/data/dtos/user_dto.dart
class UserDto {
  final String id;
  final String email;
  final String? fullname;
  // ... campos de transferencia de datos
  
  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id'],
    email: json['email'],
    fullname: json['fullname'],
  );
}

// shared/domain/vos/password_vos.dart
class PasswordVos extends ValueObject<PasswordFailure, String> {
  // Validación reutilizable de contraseñas
}

// shared/helpers/either.dart
// Helper para manejo de resultados Either<Failure, Success>

// shared/presentation/providers/global_loader/global_loader_cubit.dart
class GlobalLoaderCubit extends Cubit<bool> {
  // Loader global para toda la aplicación
}
```

### Criterios para Shared vs Feature-Specific

**Usar shared/ cuando**:
- El código es usado por múltiples features
- Son utilidades generales (helpers, extensiones)
- Son servicios globales (API, Analytics)
- Son widgets de UI genéricos

**Usar feature/ cuando**:
- El código es específico de una funcionalidad
- Contiene lógica de negocio particular
- Son widgets específicos del contexto

## Ejemplos Prácticos

### Feature de Autenticación Completo

```
auth/
├── data/
│   ├── dtos/              # (si son específicos del feature)
│   │   ├── signin_request_dto.dart
│   │   ├── signup_request_dto.dart
│   │   └── auth_response_dto.dart
│   ├── mocks/
│   │   └── mock_user.dart
│   ├── repositories/
│   │   ├── auth_repository_impl.dart
│   │   ├── secure_storage_service.dart
│   │   └── token_repository.dart
│   └── services/
│       └── firebase_social_auth_service.dart
├── domain/
│   ├── failures/
│   │   ├── oauth_sign_in_failure.dart
│   │   ├── signin_failure.dart
│   │   ├── signup_failure.dart
│   │   ├── update_document_failure.dart
│   │   └── validate_email_failure.dart
│   └── interfaces/
│       └── i_auth_repository.dart
└── presentation/
    ├── extensions/
│   │   └── oauth_sign_in_failure_extensions.dart
    ├── pages/
    │   ├── auth_page.dart
    │   └── welcome_page.dart
    ├── providers/
    │   └── auth/
    │       ├── auth_cubit.dart
    │       ├── auth_cubit.freezed.dart
    │       └── auth_state.dart
    ├── signin/
    │   ├── providers/
    │   │   ├── signin_cubit.dart
    │   │   └── signin_state.dart
    │   └── sign_in_page.dart
    ├── signup/
    │   ├── providers/
    │   │   ├── signup_cubit.dart
    │   │   └── signup_state.dart
    │   └── sign_up_page.dart
    └── widgets/
        ├── custom_text_field_widget.dart
        ├── social_login_buttons_widget.dart
        └── terms_and_conditions_widget.dart
```

### Flujo de Datos Típico

1. **User Input** → Widget captura entrada del usuario
2. **Widget** → Cubit/Provider (gestión de estado con BLoC)
3. **Cubit** → Repository Interface (a través de interface)
4. **Repository Implementation** → Service/Storage (fuente de datos)
5. **Service** → External API/Firebase/Local Storage
6. **Response** ← Flujo inverso hasta llegar al Widget

**Ejemplo práctico:**
```
LoginWidget → AuthCubit → IAuthRepository → AuthRepositoryImpl → FirebaseAuthService → Firebase
```

### Dependencias entre Capas

```
Presentation → Domain ← Data
```

- **Presentation** conoce y usa **Domain** (interfaces, models, failures)
- **Data** conoce e implementa **Domain** (interfaces)
- **Domain** no conoce las otras capas (independiente y puro)

**En la práctica:**
```dart
// ✅ Presentation → Domain
class AuthCubit {
  final IAuthRepository authRepository; // Interface de domain
  
  Future<void> signIn() async {
    final result = await authRepository.signInWithEmailAndPassword(...);
    // Maneja failures de domain
  }
}

// ✅ Data → Domain  
class AuthRepositoryImpl implements IAuthRepository { // Implementa interface de domain
  // Retorna tipos de domain (failures, models)
}

// ✅ Domain independiente
abstract class IAuthRepository {
  Future<ResultOr<SignInFailure>> signInWithEmailAndPassword(...);
  // Solo tipos puros, sin dependencias externas
}
```

## Mejores Prácticas

### 1. Mantén Domain Puro
```dart
// ✅ Correcto - Solo interfaces, models y failures puros
abstract class IAuthRepository {
  Future<ResultOr<SignInFailure>> signInWithEmailAndPassword(...);
}

class UserModel {
  // Solo datos y lógica de dominio pura
}

// ❌ Incorrecto - Dependencias externas en domain
abstract class IAuthRepository {
  Future<Response> login(...); // ❌ Response de HTTP
  Future<Either<DioError, User>> getUser(...); // ❌ DioError específico
}
```

### 2. Usa Interfaces para Inversión de Dependencias
```dart
// ✅ Correcto - Repository implementa interface de domain
abstract class IAuthRepository {
  Future<ResultOr<SignInFailure>> signInWithEmailAndPassword(...);
}

class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseSocialAuthService _firebaseService;
  // Implementación específica
}

// ✅ Cubit depende de interface, no implementación
class AuthCubit {
  final IAuthRepository authRepository; // Interface, no implementación
}
```

### 3. Usa Value Objects para Validaciones
```dart
// ✅ Correcto - Validaciones en el dominio
class EmailVos extends ValueObject<EmailFailure, String> {
  factory EmailVos(String input) {
    return EmailVos._(_validate(input.trim()));
  }
  
  static Either<EmailFailure, String> _validate(String input) {
    if (input.isEmpty) return left(EmailFailure.empty());
    if (!_isValid(input)) return left(EmailFailure.invalid());
    return right(input);
  }
}

// Uso en repository
Future<ResultOr<SignInFailure>> signInWithEmailAndPassword({
  required EmailVos email, // ✅ Ya validado
  required PasswordVos password, // ✅ Ya validado
});
```

### 4. Maneja Errores de Forma Consistente
```dart
// ✅ Usa ResultOr para manejo de errores tipados
Future<ResultOr<SignInFailure>> signIn() async {
  try {
    final user = await _firebaseService.signIn();
    return success(); // Éxito
  } on FirebaseAuthException catch (e) {
    return failure(SignInFailure.fromFirebaseError(e)); // Error tipado
  } catch (e) {
    return failure(SignInFailure.unknown()); // Error genérico
  }
}

// ✅ En el Cubit
final result = await authRepository.signInWithEmailAndPassword(...);
result.fold(
  (failure) => emit(state.copyWith(signInFailure: failure)),
  (success) => initUser(),
);
```

### 5. Usa BLoC/Cubit con Freezed
```dart
// ✅ State inmutable con Freezed
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    SignInFailure? signInFailure,
    SignUpFailure? signUpFailure,
    @Default(false) bool isLoading,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}

// ✅ Cubit con estado inmutable
class AuthCubit extends Cubit<AuthState> {
  Future<void> signIn() async {
    emit(state.copyWith(isLoading: true, signInFailure: null));
    // ... lógica
    emit(state.copyWith(isLoading: false));
  }
}
```

### 6. Testea Cada Capa Independientemente
```dart
// ✅ Test de Cubit con mock repository
test('should emit user when sign in is successful', () async {
  // Arrange
  when(mockAuthRepository.signInWithEmailAndPassword(any, any))
      .thenAnswer((_) async => success());
  
  // Act
  await authCubit.signIn();
  
  // Assert
  expect(authCubit.state.user, isNotNull);
  expect(authCubit.state.signInFailure, isNull);
});

// ✅ Test de Repository con mock service
test('should return failure when Firebase throws exception', () async {
  // Arrange
  when(mockFirebaseService.signIn())
      .thenThrow(FirebaseAuthException(code: 'user-not-found'));
  
  // Act
  final result = await authRepository.signInWithEmailAndPassword(...);
  
  // Assert
  expect(result.isFailure, true);
  expect(result.failure, isA<SignInFailureUserNotFound>());
});
```

## Checklist de Feature

Al crear un nuevo feature, asegúrate de:

**Estructura base:**
- [ ] Crear estructura de carpetas completa (data/domain/presentation)

**Capa Domain:**
- [ ] Definir interfaces en domain/interfaces/
- [ ] Crear modelos de dominio en domain/models/ (si son específicos del feature)
- [ ] Definir tipos y enums en domain/types/
- [ ] Crear value objects en domain/vos/ (si es necesario)
- [ ] Definir failures específicos en domain/failures/
- [ ] Crear extensions para failures en domain/failures_extensions/

**Capa Data:**
- [ ] Crear DTOs en data/dtos/ (si son específicos del feature)
- [ ] Implementar repositorio en data/repositories/
- [ ] Crear servicios específicos en data/services/
- [ ] Agregar mocks en data/mocks/ para testing
- [ ] Asegurar conversión correcta de DTOs a modelos de dominio

**Capa Presentation:**
- [ ] Crear páginas principales en presentation/pages/
- [ ] Implementar Cubits/Providers en presentation/providers/
- [ ] Organizar sub-features en carpetas específicas (ej: signin/, signup/)
- [ ] Crear widgets reutilizables en presentation/widgets/

**Testing y calidad:**
- [ ] Agregar tests unitarios para cada capa
- [ ] Documentar APIs y casos de uso principales
- [ ] Verificar que domain no tenga dependencias externas
- [ ] Asegurar que las interfaces estén bien definidas

**Integración:**
- [ ] Registrar dependencias en el DI container
- [ ] Agregar rutas en el router si es necesario
- [ ] Integrar con providers globales (auth, loader, etc.)
- [ ] Añadir traducciones en l10n si es necesario

**Shared vs Feature-specific:**
- [ ] Evaluar qué código puede ir a shared/
- [ ] Mover modelos comunes a shared/domain/models/
- [ ] Compartir value objects reutilizables en shared/domain/vos/
- [ ] Usar tipos globales desde shared/domain/types/
