# Convenciones de Nomenclatura

## Tabla de Contenidos

- [Archivos y Carpetas](#archivos-y-carpetas)
- [Clases](#clases)
- [Variables y Funciones](#variables-y-funciones)
- [Constantes](#constantes)
- [Widgets](#widgets)
- [Providers y BLoC](#providers-y-bloc)
- [Assets](#assets)

## Archivos y Carpetas

### Carpetas
- **snake_case**: Todas las carpetas usan snake_case
- **Descriptivas**: Nombres descriptivos y específicos

```
✅ Correcto:
auth/
user_profile/
settings/
shared/
presentation/

❌ Incorrecto:
Auth/
userProfile/
UserSettings/
```

### Archivos Dart
- **snake_case**: Todos los archivos .dart usan snake_case
- **Sufijos descriptivos**: Incluir el tipo de archivo cuando sea relevante

```
✅ Correcto:
login_page.dart
user_repository.dart
auth_provider.dart
custom_button.dart
api_service.dart

❌ Incorrecto:
LoginPage.dart
userRepository.dart
AuthProvider.dart
```

### Archivos de Assets
- **snake_case**: Para mantener consistencia
- **Prefijos descriptivos**: Indicar el tipo de asset

```
✅ Correcto:
icon_user.svg
image_splash_background.png
lottie_loading_animation.json
font_roboto_regular.ttf

❌ Incorrecto:
UserIcon.svg
splashBg.png
loadingAnim.json
```

## Clases

### Clases Generales
- **PascalCase**: Primera letra de cada palabra en mayúscula
- **Descriptivas**: Nombres claros y específicos
- **Sufijos específicos**: Según el tipo de clase

```dart
✅ Correcto:
class UserRepository {}
class AuthProvider {}
class LoginPage {}
class CustomButton {}
class ApiService {}

❌ Incorrecto:
class userRepository {}
class authprovider {}
class loginpage {}
```

### Widgets
- **Sufijo Widget**: Todos los widgets personalizados terminan en "Widget"
- **Descriptivos**: Indicar claramente su propósito

```dart
✅ Correcto:
class CustomElevatedButtonWidget {}
class UserProfileCardWidget {}
class LoadingIndicatorWidget {}
class SelectImageWidget {}

❌ Incorrecto:
class CustomButton {}
class UserCard {}
class Loading {}
```

### Páginas
- **Sufijo Page**: Todas las páginas terminan en "Page"

```dart
✅ Correcto:
class LoginPage {}
class HomePage {}
class UserProfilePage {}
class SettingsPage {}

❌ Incorrecto:
class Login {}
class Home {}
class UserProfile {}
```

### Providers y BLoC
- **Sufijos específicos**: Provider, Cubit, Bloc según corresponda

```dart
✅ Correcto:
class AuthProvider {}
class UserCubit {}
class NavigationBloc {}
class ThemeProvider {}

❌ Incorrecto:
class Auth {}
class User {}
class Navigation {}
```

## Variables y Funciones

### Variables
- **camelCase**: Primera palabra en minúscula, siguientes en PascalCase
- **Descriptivas**: Nombres claros que indiquen el propósito

```dart
✅ Correcto:
String userName;
bool isLoggedIn;
int maxRetryAttempts;
List<User> availableUsers;

❌ Incorrecto:
String un;
bool logged;
int max;
List<User> users; // muy genérico
```

### Variables Privadas
- **Underscore prefix**: Variables privadas empiezan con _

```dart
✅ Correcto:
String _authToken;
bool _isLoading;
User? _currentUser;

❌ Incorrecto:
String authToken; // si debe ser privada
bool isLoading; // si debe ser privada
```

### Funciones
- **camelCase**: Igual que las variables
- **Verbos descriptivos**: Empezar con verbo que indique la acción

```dart
✅ Correcto:
void loginUser() {}
Future<User> fetchUserProfile() {}
bool validateEmail(String email) {}
void _handleLoginSuccess() {}

❌ Incorrecto:
void login() {} // muy genérico
Future<User> user() {} // no indica acción
bool email(String email) {} // no descriptivo
```

### Funciones Privadas
- **Underscore prefix**: Funciones privadas empiezan con _

```dart
✅ Correcto:
void _validateForm() {}
Future<void> _saveUserPreferences() {}
String _formatPhoneNumber(String phone) {}

❌ Incorrecto:
void validateForm() {} // si debe ser privada
```

## Constantes

### Constantes Globales
- **camelCase**: Dart usa camelCase para constantes, no SCREAMING_SNAKE_CASE
- **Agrupadas en clases**: Organizadas por contexto
- **const/static const**: Usar const cuando sea posible

```dart
✅ Correcto:
class AppConstants {
  static const String apiBaseUrl = 'https://api.example.com';
  static const int maxRetryAttempts = 3;
  static const Duration timeoutDuration = Duration(seconds: 30);
}

class ColorConstants {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFF9800);
}

❌ Incorrecto:
const String API_BASE_URL = 'https://api.example.com'; // SCREAMING_SNAKE_CASE no es Dart
const int MAX_RETRY_ATTEMPTS = 3;
```

### Constantes de Configuración
- **Archivos específicos**: Separadas por contexto
- **Nombres descriptivos**: Claros y específicos

```dart
// api_constants.dart
class ApiConstants {
  static const String loginEndpoint = '/auth/login';
  static const String userProfileEndpoint = '/user/profile';
}

// ui_constants.dart
class UiConstants {
  static const double defaultPadding = 16.0;
  static const double borderRadius = 8.0;
}
```

## Widgets

### Widgets Personalizados
- **Sufijo Widget**: Siempre terminar en "Widget"
- **Descriptivos**: Indicar claramente su propósito

```dart
✅ Correcto:
class CustomElevatedButtonWidget extends StatelessWidget {}
class UserAvatarWidget extends StatelessWidget {}
class LoadingOverlayWidget extends StatefulWidget {}

❌ Incorrecto:
class CustomButton extends StatelessWidget {}
class Avatar extends StatelessWidget {}
class Loading extends StatefulWidget {}
```

### Widgets de Estado
- **State suffix**: Para las clases State correspondientes

```dart
✅ Correcto:
class LoginFormWidget extends StatefulWidget {}
class _LoginFormWidgetState extends State<LoginFormWidget> {}

❌ Incorrecto:
class LoginFormWidget extends StatefulWidget {}
class LoginFormState extends State<LoginFormWidget> {}
```

## Providers y BLoC

### Providers
- **Sufijo Provider**: Para providers de estado
- **Descriptivos**: Indicar qué estado manejan

```dart
✅ Correcto:
class AuthProvider extends ChangeNotifier {}
class ThemeProvider extends ChangeNotifier {}
class UserPreferencesProvider extends ChangeNotifier {}

❌ Incorrecto:
class Auth extends ChangeNotifier {}
class Theme extends ChangeNotifier {}
```

### BLoC/Cubit
- **Sufijos específicos**: Bloc o Cubit según corresponda
- **Estados y eventos**: Sufijos State y Event

```dart
✅ Correcto:
class AuthCubit extends Cubit<AuthState> {}
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {}

// Estados
abstract class AuthState {}
class AuthInitialState extends AuthState {}
class AuthLoadingState extends AuthState {}

// Eventos
abstract class NavigationEvent {}
class NavigateToHomeEvent extends NavigationEvent {}

❌ Incorrecto:
class Auth extends Cubit<AuthState> {}
class Navigation extends Bloc<NavigationEvent, NavigationState> {}
```

## Assets

### Imágenes
- **Prefijo**: `image_` para imágenes
- **Descriptivo**: Indicar uso o contenido

```
✅ Correcto:
image_splash_background.png
image_user_placeholder.png
image_logo_company.svg

❌ Incorrecto:
background.png
placeholder.png
logo.svg
```

### Iconos
- **Prefijo**: `icon_` para iconos
- **Descriptivo**: Indicar función del icono

```
✅ Correcto:
icon_home.svg
icon_user_profile.svg
icon_settings.svg
icon_arrow_back.svg

❌ Incorrecto:
home.svg
user.svg
settings.svg
```

### Animaciones
- **Prefijo**: `lottie_` o `rive_` según tipo
- **Descriptivo**: Indicar propósito de la animación

```
✅ Correcto:
lottie_loading_spinner.json
lottie_success_checkmark.json
rive_character_walk.riv

❌ Incorrecto:
loading.json
success.json
character.riv
```

## Ejemplos Prácticos

### Estructura de Feature Completa

```
auth/
├── data/
│   ├── datasources/
│   │   ├── auth_local_datasource.dart
│   │   └── auth_remote_datasource.dart
│   ├── dtos/
│   │   ├── user_dto.dart
│   │   └── login_response_dto.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── models/
│   │   └── user_model.dart
│   ├── types/
│   │   ├── auth_error_type.dart
│   │   └── login_state_type.dart
│   ├── failures/
│   │   └── auth_failure.dart
│   └── interfaces/
│       └── i_auth_repository.dart
├── application/
│   └── usecases/
│       ├── login_usecase.dart
│       └── logout_usecase.dart
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   └── signup_page.dart
    ├── providers/
    │   └── auth_cubit.dart
    └── widgets/
        ├── login_form_widget.dart
        └── social_login_buttons_widget.dart
```

### Archivo de Ejemplo

```dart
// login_form_widget.dart
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final String? initialEmail;
  
  const LoginFormWidget({
    super.key,
    this.onLoginSuccess,
    this.initialEmail,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialEmail != null) {
      _emailController.text = widget.initialEmail!;
    }
  }

  Future<void> _handleLoginSubmit() async {
    // Implementación del login
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Implementación del widget
  }
}
```

## Checklist de Nomenclatura

- [ ] Carpetas en snake_case
- [ ] Archivos .dart en snake_case con sufijos descriptivos
- [ ] Clases en PascalCase con sufijos apropiados
- [ ] Variables y funciones en camelCase
- [ ] Variables y funciones privadas con prefijo _
- [ ] Constantes en camelCase (no SCREAMING_SNAKE_CASE)
- [ ] Widgets con sufijo Widget
- [ ] Páginas con sufijo Page
- [ ] Providers con sufijo Provider/Cubit/Bloc
- [ ] Assets con prefijos descriptivos
- [ ] Nombres descriptivos y claros en todos los casos
- [ ] DTOs en data layer, models en domain layer
- [ ] UseCases en application layer, no en domain
