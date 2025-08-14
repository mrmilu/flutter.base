# Testing

## Introducción

Flutter Base implementa una estrategia de testing completa que abarca **unit tests**, **widget tests**, **integration tests** y **golden tests**. Este documento describe la configuración, patrones y mejores prácticas para testing en el proyecto, siguiendo los principios de Clean Architecture y Vertical Slice Architecture.

## Tabla de Contenidos

- [Configuración de Testing](#configuración-de-testing)
- [Tipos de Tests](#tipos-de-tests)
- [Unit Tests](#unit-tests)
- [Widget Tests](#widget-tests)
- [Integration Tests](#integration-tests)
- [Golden Tests](#golden-tests)
- [Mocking y Test Doubles](#mocking-y-test-doubles)
- [Testing de BLoC](#testing-de-bloc)
- [Testing Utilities](#testing-utilities)
- [Mejores Prácticas](#mejores-prácticas)

## Configuración de Testing

### Dependencias de Testing

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.2
  build_runner: ^2.4.7
  bloc_test: ^9.1.4
  mocktail: ^1.0.0
  golden_toolkit: ^0.15.0
  network_image_mock: ^2.1.1
  patrol: ^2.6.0
```

### Estructura de Tests

```
test/
├── fixtures/                    # Datos de prueba
│   ├── auth/
│   │   ├── user_fixture.dart
│   │   └── auth_response_fixture.dart
│   └── home/
│       └── home_data_fixture.dart
├── helpers/                     # Utilidades para testing
│   ├── test_helpers.dart
│   ├── pump_app.dart
│   └── mock_dependencies.dart
├── unit/                       # Unit tests
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── shared/
├── widget/                     # Widget tests
│   ├── auth/
│   └── shared/
└── integration/               # Integration tests
    ├── app_test.dart
    └── auth_flow_test.dart

integration_test/              # Integration tests para dispositivos
├── app_test.dart
└── auth_flow_test.dart
```

## Tipos de Tests

### Pirámide de Testing

```
    🔺 Integration Tests (Pocos)
   🔺🔺 Widget Tests (Algunos)
🔺🔺🔺🔺 Unit Tests (Muchos)
```

- **Unit Tests**: Lógica de negocio, repositorios, casos de uso
- **Widget Tests**: Comportamiento de widgets individuales
- **Integration Tests**: Flujos completos de la aplicación
- **Golden Tests**: Apariencia visual de widgets

## Unit Tests

### Testing de Repositorios

```dart
// test/unit/auth/data/repositories/auth_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../../fixtures/auth/auth_fixtures.dart';
import '../../../../helpers/test_helpers.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDataSource>(),
  MockSpec<AuthLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'auth_repository_test.mocks.dart';

void main() {
  group('AuthRepository', () {
    late AuthRepositoryImpl repository;
    late MockAuthRemoteDataSource mockRemoteDataSource;
    late MockAuthLocalDataSource mockLocalDataSource;
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockRemoteDataSource = MockAuthRemoteDataSource();
      mockLocalDataSource = MockAuthLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      
      repository = AuthRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );
    });

    group('signIn', () {
      const email = 'test@example.com';
      const password = 'password123';
      final userModel = AuthFixtures.userModel;

      test('should return user when sign in is successful', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.signIn(email, password))
            .thenAnswer((_) async => userModel);
        when(mockLocalDataSource.cacheUser(userModel))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.signIn(email, password);

        // Assert
        expect(result, isA<Right<Failure, UserEntity>>());
        result.fold(
          (failure) => fail('Expected success'),
          (user) => expect(user.email, equals(email)),
        );
        
        verify(mockRemoteDataSource.signIn(email, password));
        verify(mockLocalDataSource.cacheUser(userModel));
      });

      test('should return network failure when device is offline', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // Act
        final result = await repository.signIn(email, password);

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (user) => fail('Expected failure'),
        );
        
        verifyNever(mockRemoteDataSource.signIn(any, any));
      });

      test('should return server failure when remote call fails', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.signIn(email, password))
            .thenThrow(ServerException());

        // Act
        final result = await repository.signIn(email, password);

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (user) => fail('Expected failure'),
        );
      });
    });
  });
}
```

### Testing de Casos de Uso

```dart
// test/unit/auth/domain/usecases/sign_in_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../../fixtures/auth/auth_fixtures.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
import 'sign_in_usecase_test.mocks.dart';

void main() {
  group('SignInUseCase', () {
    late SignInUseCase usecase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      usecase = SignInUseCase(mockRepository);
    });

    test('should get user from repository when credentials are valid', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      final user = AuthFixtures.userEntity;
      
      when(mockRepository.signIn(email, password))
          .thenAnswer((_) async => Right(user));

      // Act
      final result = await usecase(SignInParams(
        email: email,
        password: password,
      ));

      // Assert
      expect(result, Right(user));
      verify(mockRepository.signIn(email, password));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'wrong_password';
      final failure = InvalidCredentialsFailure();
      
      when(mockRepository.signIn(email, password))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await usecase(SignInParams(
        email: email,
        password: password,
      ));

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.signIn(email, password));
    });

    group('validation', () {
      test('should return validation failure for invalid email', () async {
        // Act
        final result = await usecase(SignInParams(
          email: 'invalid_email',
          password: 'password123',
        ));

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (user) => fail('Expected validation failure'),
        );
      });

      test('should return validation failure for short password', () async {
        // Act
        final result = await usecase(SignInParams(
          email: 'test@example.com',
          password: '123',
        ));

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (user) => fail('Expected validation failure'),
        );
      });
    });
  });
}
```

## Widget Tests

### Testing de Widgets Básicos

```dart
// test/widget/shared/widgets/custom_button_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('CustomButton', () {
    testWidgets('should display text correctly', (tester) async {
      // Arrange
      const buttonText = 'Test Button';
      
      // Act
      await tester.pumpApp(
        CustomButton(
          text: buttonText,
          onPressed: () {},
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      // Arrange
      var wasPressed = false;
      
      // Act
      await tester.pumpApp(
        CustomButton(
          text: 'Test Button',
          onPressed: () => wasPressed = true,
        ),
      );
      
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(wasPressed, isTrue);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      // Act
      await tester.pumpApp(
        const CustomButton(
          text: 'Disabled Button',
          onPressed: null,
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should show loading indicator when isLoading is true', (tester) async {
      // Act
      await tester.pumpApp(
        CustomButton(
          text: 'Loading Button',
          onPressed: () {},
          isLoading: true,
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });
  });
}
```

### Testing de Páginas

```dart
// test/widget/auth/pages/sign_in_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/mock_dependencies.dart';

void main() {
  group('SignInPage', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    Widget createWidgetUnderTest() {
      return BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const SignInPage(),
      );
    }

    testWidgets('should display email and password fields', (tester) async {
      // Arrange
      when(mockAuthBloc.state).thenReturn(AuthInitial());

      // Act
      await tester.pumpApp(createWidgetUnderTest());

      // Assert
      expect(find.byKey(const Key('email_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);
      expect(find.byKey(const Key('sign_in_button')), findsOneWidget);
    });

    testWidgets('should show loading when state is loading', (tester) async {
      // Arrange
      when(mockAuthBloc.state).thenReturn(AuthLoading());

      // Act
      await tester.pumpApp(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is error', (tester) async {
      // Arrange
      const errorMessage = 'Invalid credentials';
      when(mockAuthBloc.state).thenReturn(
        AuthError(message: errorMessage),
      );

      // Act
      await tester.pumpApp(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should trigger sign in event when form is submitted', (tester) async {
      // Arrange
      when(mockAuthBloc.state).thenReturn(AuthInitial());
      const email = 'test@example.com';
      const password = 'password123';

      // Act
      await tester.pumpApp(createWidgetUnderTest());
      
      await tester.enterText(find.byKey(const Key('email_field')), email);
      await tester.enterText(find.byKey(const Key('password_field')), password);
      await tester.tap(find.byKey(const Key('sign_in_button')));
      await tester.pump();

      // Assert
      verify(mockAuthBloc.add(SignInRequested(
        email: email,
        password: password,
      ))).called(1);
    });
  });
}
```

## Integration Tests

### Testing de Flujos Completos

```dart
// integration_test/auth_flow_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_base/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Flow Integration Tests', () {
    testWidgets('complete sign in flow', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Navigate to sign in
      await tester.tap(find.byKey(const Key('go_to_sign_in')));
      await tester.pumpAndSettle();

      // Fill form
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );

      // Submit form
      await tester.tap(find.byKey(const Key('sign_in_button')));
      await tester.pumpAndSettle();

      // Verify success
      expect(find.byKey(const Key('home_page')), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
    });

    testWidgets('sign up flow with validation errors', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Navigate to sign up
      await tester.tap(find.byKey(const Key('go_to_sign_up')));
      await tester.pumpAndSettle();

      // Try to submit empty form
      await tester.tap(find.byKey(const Key('sign_up_button')));
      await tester.pumpAndSettle();

      // Verify validation errors
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);

      // Fill valid data
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'newuser@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'securepassword123',
      );
      await tester.enterText(
        find.byKey(const Key('confirm_password_field')),
        'securepassword123',
      );

      // Submit form
      await tester.tap(find.byKey(const Key('sign_up_button')));
      await tester.pumpAndSettle();

      // Verify success
      expect(find.text('Account created successfully'), findsOneWidget);
    });
  });
}
```

### Testing con Patrol

```dart
// integration_test/patrol_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('user can sign in and navigate through app', (PatrolTester $) async {
    // Launch app
    await $.pumpWidget(MyApp());

    // Navigate to sign in
    await $(#goToSignInButton).tap();

    // Fill credentials
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');

    // Sign in
    await $(#signInButton).tap();

    // Verify home screen
    await $(#homeScreen).waitUntilVisible();
    expect($(#welcomeMessage), findsOneWidget);

    // Navigate to settings
    await $(#settingsTab).tap();
    await $(#settingsScreen).waitUntilVisible();

    // Open profile
    await $(#profileOption).tap();
    await $(#profileScreen).waitUntilVisible();

    // Verify profile data
    expect($(#userEmail), findsOneWidget);
    expect($('test@example.com'), findsOneWidget);
  });
}
```

## Golden Tests

### Testing de Apariencia Visual

```dart
// test/widget/golden/home_page_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('HomePage Golden Tests', () {
    testGoldens('home page renders correctly', (tester) async {
      // Arrange
      await loadAppFonts();
      
      // Act
      await tester.pumpWidgetBuilder(
        const HomePage(),
        surfaceSize: const Size(375, 812), // iPhone X size
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
          localizations: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
      );

      // Assert
      await screenMatchesGolden(tester, 'home_page_light');
    });

    testGoldens('home page renders correctly in dark mode', (tester) async {
      // Arrange
      await loadAppFonts();
      
      // Act
      await tester.pumpWidgetBuilder(
        const HomePage(),
        surfaceSize: const Size(375, 812),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
          localizations: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
      );

      // Assert
      await screenMatchesGolden(tester, 'home_page_dark');
    });

    testGoldens('home page with different screen sizes', (tester) async {
      await loadAppFonts();
      
      final devices = [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ];

      for (final device in devices) {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: const HomePage(),
              name: 'default',
            ),
          wrapper: materialAppWrapper(),
        );

        await screenMatchesGolden(
          tester,
          'home_page_${device.name}',
        );
      }
    });
  });
}
```

## Testing de BLoC

### Testing de Estados y Eventos

```dart
// test/unit/auth/presentation/bloc/auth_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/auth/auth_fixtures.dart';
import '../../../../helpers/mock_dependencies.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockSignInUseCase mockSignInUseCase;
    late MockSignUpUseCase mockSignUpUseCase;
    late MockSignOutUseCase mockSignOutUseCase;

    setUp(() {
      mockSignInUseCase = MockSignInUseCase();
      mockSignUpUseCase = MockSignUpUseCase();
      mockSignOutUseCase = MockSignOutUseCase();
      
      authBloc = AuthBloc(
        signInUseCase: mockSignInUseCase,
        signUpUseCase: mockSignUpUseCase,
        signOutUseCase: mockSignOutUseCase,
      );
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    group('SignInRequested', () {
      const email = 'test@example.com';
      const password = 'password123';
      final user = AuthFixtures.userEntity;

      blocTest<AuthBloc, AuthState>(
        'should emit [loading, success] when sign in succeeds',
        build: () {
          when(mockSignInUseCase(any))
              .thenAnswer((_) async => Right(user));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInRequested(email: email, password: password),
        ),
        expect: () => [
          AuthLoading(),
          AuthSuccess(user: user),
        ],
        verify: (_) {
          verify(mockSignInUseCase(
            SignInParams(email: email, password: password),
          ));
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [loading, error] when sign in fails',
        build: () {
          when(mockSignInUseCase(any))
              .thenAnswer((_) async => Left(InvalidCredentialsFailure()));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInRequested(email: email, password: password),
        ),
        expect: () => [
          AuthLoading(),
          const AuthError(message: 'Invalid credentials'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [loading, error] when network fails',
        build: () {
          when(mockSignInUseCase(any))
              .thenAnswer((_) async => Left(NetworkFailure()));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInRequested(email: email, password: password),
        ),
        expect: () => [
          AuthLoading(),
          const AuthError(message: 'Network error. Check your connection.'),
        ],
      );
    });

    group('SignOutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [loading, initial] when sign out succeeds',
        build: () {
          when(mockSignOutUseCase(any))
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(SignOutRequested()),
        expect: () => [
          AuthLoading(),
          AuthInitial(),
        ],
      );
    });
  });
}
```

## Testing Utilities

### Helpers de Testing

```dart
// test/helpers/pump_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mock_dependencies.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ThemeData? theme,
    List<BlocProvider> providers = const [],
  }) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          ...providers,
          BlocProvider<AuthBloc>.value(value: MockAuthBloc()),
          BlocProvider<ThemeBloc>.value(value: MockThemeBloc()),
        ],
        child: MaterialApp(
          theme: theme ?? ThemeData.light(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', 'ES'),
            Locale('en', 'US'),
          ],
          home: widget,
        ),
      ),
    );
  }
}
```

### Fixtures de Datos

```dart
// test/fixtures/auth/auth_fixtures.dart
import 'package:flutter_base/src/auth/data/models/user_model.dart';
import 'package:flutter_base/src/auth/domain/entities/user_entity.dart';

class AuthFixtures {
  static const userEntity = UserEntity(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
    isEmailVerified: true,
    hasCompletedProfile: true,
    createdAt: '2024-01-01T00:00:00Z',
  );

  static const userModel = UserModel(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
    isEmailVerified: true,
    hasCompletedProfile: true,
    createdAt: '2024-01-01T00:00:00Z',
  );

  static const invalidUserEntity = UserEntity(
    id: '',
    email: 'invalid-email',
    name: '',
    isEmailVerified: false,
    hasCompletedProfile: false,
    createdAt: '2024-01-01T00:00:00Z',
  );
}
```

## Mejores Prácticas

### 1. Naming Conventions

```dart
// ✅ Correcto
void main() {
  group('AuthRepository', () {
    group('signIn', () {
      test('should return user when credentials are valid', () async {
        // Test implementation
      });
      
      test('should return failure when credentials are invalid', () async {
        // Test implementation
      });
    });
  });
}
```

### 2. Arrange-Act-Assert (AAA)

```dart
test('should return success when data is valid', () async {
  // Arrange
  const email = 'test@example.com';
  const password = 'password123';
  when(mockRepository.signIn(email, password))
      .thenAnswer((_) async => Right(userEntity));

  // Act
  final result = await usecase(SignInParams(
    email: email,
    password: password,
  ));

  // Assert
  expect(result, isA<Right<Failure, UserEntity>>());
  verify(mockRepository.signIn(email, password));
});
```

### 3. Isolation de Tests

```dart
// ✅ Correcto - Cada test es independiente
setUp(() {
  mockRepository = MockRepository();
  usecase = UseCase(mockRepository);
});

tearDown(() {
  reset(mockRepository);
});
```

### 4. Coverage Goals

```bash
 fvm flutter test integration_test/{flavor}/{test_file}.dart --flavor {flavor} -d {deviceId}
```