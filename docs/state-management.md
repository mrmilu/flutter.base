# Gestión de Estado con Cubit

## Introducción

Flutter Base utiliza **Cubit** como única solución para la gestión de estado. El proyecto no usa BLoC ni Provider, se enfoca completamente en Cubit por su simplicidad y funcionalidad directa. Este documento describe los patrones, estructuras y ejemplos reales utilizados en el proyecto.

## Tabla de Contenidos

- [¿Por qué Cubit?](#¿por-qué-cubit)
- [Arquitectura de Estado](#arquitectura-de-estado)
- [BaseCubit](#basecubit)
- [Patrones de Estado](#patrones-de-estado)
- [Cubits Globales](#cubits-globales)
- [Cubits de Feature](#cubits-de-feature)
- [Integración con UI](#integración-con-ui)
- [Ejemplos Reales del Proyecto](#ejemplos-reales-del-proyecto)
- [Testing](#testing)
- [Mejores Prácticas](#mejores-prácticas)
- [Checklist de Gestión de Estado](#checklist-de-gestión-de-estado)

## ¿Por qué Cubit?

Flutter Base eligió Cubit como única solución de gestión de estado porque:

1. **Simplicidad**: Métodos directos sin eventos complejos
2. **Menos boilerplate**: No requiere definir eventos separados
3. **Fácil testing**: Estados directos y métodos simples
4. **Rendimiento**: Menos overhead que BLoC completo
5. **Mantenibilidad**: Código más limpio y fácil de entender

## Arquitectura de Estado

### Principios del Proyecto

1. **Separación de responsabilidades**: Lógica de negocio separada de la UI
2. **Estados inmutables**: Usando Freezed para immutabilidad
3. **Flujo unidireccional**: Estados fluyen desde Cubit hacia la UI
4. **BaseCubit**: Clase base común para prevenir memory leaks
5. **Dependency Injection**: Usando GetIt para inyección de dependencias

### Jerarquía de Estado Real

```
Global State (App Level)
├── GlobalLoaderCubit (Loading overlay global)
├── LocaleCubit (Idioma de la aplicación)
├── ThemeModeCubit (Tema claro/oscuro)
├── AppSettingsCubit (Configuraciones de Firebase)
└── AuthCubit (Usuario autenticado)

Feature State (Feature Level)
├── Auth Feature
│   ├── SigninCubit (Login)
│   ├── SignupCubit (Registro)
│   ├── ForgotPasswordCubit (Recuperar contraseña)
│   ├── ResetPasswordCubit (Cambiar contraseña)
│   ├── UpdateDocumentCubit (Actualizar documento)
│   ├── ValidateEmailCubit (Validar email)
│   └── SigninSocialCubit (Login social)
├── Settings Feature
│   ├── PersonalDataCubit (Datos personales)
│   ├── ChangeEmailCubit (Cambiar email)
│   ├── ChangePasswordCubit (Cambiar contraseña)
│   ├── RequiredPasswordCubit (Verificar contraseña)
│   ├── ChangeLanguageCubit (Cambiar idioma)
│   └── DeleteAccountCubit (Eliminar cuenta)
├── Home Feature
│   └── MainHomeCubit (Dashboard principal)
├── Splash Feature
│   └── SplashCubit (Pantalla de carga inicial)
└── Shared Feature
    └── DownloadFileCubit (Descarga de archivos)
```


## BaseCubit

Todos los Cubits del proyecto extienden de `BaseCubit`, que proporciona funcionalidad esencial para prevenir memory leaks:

```dart
// lib/src/shared/presentation/providers/base_cubit.dart
abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  bool isDisposed = false;

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }

  void emitIfNotDisposed(State state) {
    if (!isDisposed) {
      emit(state);
    }
  }
}
```

### Ventajas de BaseCubit

1. **Previene memory leaks**: Evita emitir estados después de dispose
2. **Consistencia**: Todos los Cubits siguen el mismo patrón
3. **Seguridad**: No hay errores por emitir en Cubits cerrados
4. **Debugging**: Facilita el tracking de estados

### Uso Correcto

```dart
// ✅ Correcto - Usar emitIfNotDisposed
class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({required this.authRepository}) : super(SigninState.initial());
  
  Future<void> signin() async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}

// ❌ Incorrecto - Usar emit directamente
class BadCubit extends BaseCubit<SomeState> {
  void updateState() {
    emit(newState); // Puede causar errores si el Cubit está cerrado
  }
}
```

## Patrones de Estado

El proyecto utiliza tres tipos principales de estado con Freezed para inmutabilidad:

### 1. Estados con Resource<F, T>

Para operaciones que requieren datos del servidor con manejo de errores:

```dart
// Estados que usan Resource
@freezed
abstract class MainHomeState with _$MainHomeState {
  factory MainHomeState({
    required Resource<GeneralFailure, List<ProductModel>> resourceGetProducts,
  }) = _MainHomeState;

  factory MainHomeState.initial() => _MainHomeState(
    resourceGetProducts: Resource.none(),
  );
}

// Uso en Cubit
class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit({required this.repository}) : super(MainHomeState.initial());
  
  final IMainHomeRepository repository;

  Future<void> getProducts() async {
    emit(state.copyWith(resourceGetProducts: Resource.loading()));
    final result = await repository.getProducts();
    emit(state.copyWith(resourceGetProducts: result));
  }
}
```

### 2. Estados con ResultOr<F>

Para operaciones que solo necesitan saber éxito/error sin datos:

```dart
// Estados que usan ResultOr
@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required ResultOr<SignInFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  // Getters para Value Objects
  EmailVos get emailVos => EmailVos(email);
  PasswordVos get passwordVos => PasswordVos(password);
}

// Uso en Cubit
class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin() async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
```

### 3. Estados Simples

Para configuraciones y estados simples:

```dart
// Estados simples usando Freezed
@freezed
abstract class LocaleState with _$LocaleState {
  factory LocaleState({
    required String languageCode,
  }) = _LocaleState;

  factory LocaleState.initial() => _LocaleState(
    languageCode: 'es',
  );

  LocaleState._();

  // Getter computado
  Locale get locale => Locale.fromSubtags(languageCode: languageCode);
}

@freezed
abstract class ThemeModeState with _$ThemeModeState {
  factory ThemeModeState({
    required bool isDarkMode,
  }) = _ThemeModeState;

  factory ThemeModeState.initial() => _ThemeModeState(
    isDarkMode: false,
  );
}
```

## Cubits Globales

Los Cubits globales se configuran una vez en la aplicación y están disponibles en todo el árbol de widgets:

### GlobalLoaderCubit - Loader Global

Maneja el overlay de carga global de la aplicación:

```dart
// lib/src/shared/presentation/providers/global_loader/global_loader_cubit.dart
@freezed
abstract class GlobalLoaderState with _$GlobalLoaderState {
  factory GlobalLoaderState({
    required OverlayEntry? globalLoaderEntry,
    required bool hideLoaderOverlayEntry,
  }) = _GlobalLoaderState;

  factory GlobalLoaderState.initial() => _GlobalLoaderState(
    globalLoaderEntry: null,
    hideLoaderOverlayEntry: false,
  );
}

class GlobalLoaderCubit extends Cubit<GlobalLoaderState> {
  GlobalLoaderCubit() : super(GlobalLoaderState.initial());
  bool _globalEntryAdded = false;

  void show() {
    if (_globalEntryAdded) return;
    final context = rootNavigatorKey.currentState?.overlay?.context;
    if (context == null) return;
    OverlayEntry overlayEntry = GlobalCircularProgress.build(context);
    rootNavigatorKey.currentState?.overlay?.insert(overlayEntry);
    _globalEntryAdded = true;
    emit(state.copyWith(globalLoaderEntry: overlayEntry));
  }

  void hide() {
    emit(state.copyWith(hideLoaderOverlayEntry: true));
    Future.delayed(const Duration(milliseconds: 400), () {
      state.globalLoaderEntry?.remove();
      _globalEntryAdded = false;
      emit(state.copyWith(
        hideLoaderOverlayEntry: false,
        globalLoaderEntry: null,
      ));
    });
  }
}

// Uso en otros Cubits
class SigninCubit extends BaseCubit<SigninState> {
  final GlobalLoaderCubit globalLoaderCubit;
  
  Future<void> signin() async {
    globalLoaderCubit.show(); // Mostrar loader
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    globalLoaderCubit.hide(); // Ocultar loader
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
```

### LocaleCubit - Idioma de la App

Maneja el idioma actual de la aplicación:

```dart
// lib/src/locale/presentation/providers/locale_cubit.dart
@freezed
abstract class LocaleState with _$LocaleState {
  factory LocaleState({
    required String languageCode,
  }) = _LocaleState;

  factory LocaleState.initial() => _LocaleState(
    languageCode: 'es',
  );

  LocaleState._();

  Locale get locale => Locale.fromSubtags(languageCode: languageCode);
}

class LocaleCubit extends Cubit<LocaleState> {
  final ILocaleRepository localeRepository;

  LocaleCubit({required this.localeRepository}) : super(LocaleState.initial());

  Future<void> changeLanguage(String languageCode) async {
    await localeRepository.changeLanguageCode(languageCode);
    emit(state.copyWith(languageCode: languageCode));
  }

  void loadLocale(String languageCode) async {
    final localeLoad = await localeRepository.findLanguageCode();
    if (localeLoad != null) {
      emit(state.copyWith(languageCode: localeLoad));
    } else {
      emit(state.copyWith(languageCode: languageCode));
    }
  }
}
```

### ThemeModeCubit - Tema de la App

Controla el tema claro/oscuro:

```dart
// lib/src/shared/presentation/providers/theme_mode/theme_mode_cubit.dart
@freezed
abstract class ThemeModeState with _$ThemeModeState {
  factory ThemeModeState({
    required bool isDarkMode,
  }) = _ThemeModeState;

  factory ThemeModeState.initial() => _ThemeModeState(
    isDarkMode: false,
  );
}

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeState.initial());

  void toggleTheme() {
    final isDarkMode = !state.isDarkMode;
    changeThemeMode(isDarkMode);
  }

  Future<void> changeThemeMode(bool isDarkMode) async {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}
```

### AuthCubit - Usuario Autenticado

Maneja el estado de autenticación global:

```dart
// lib/src/auth/presentation/providers/auth/auth_cubit.dart
@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required UserModel? user,
  }) = _AuthState;

  factory AuthState.initial() => _AuthState(
    user: null,
  );
}

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;
  
  AuthCubit({required this.authRepository, required this.globalLoaderCubit})
    : super(AuthState.initial());

  Future<void> initUser() async {
    final user = await authRepository.getUser();
    if (user != null && user.document != null) {
      createTokenDevice();
    }
    emit(state.copyWith(user: user));
  }

  Future<void> logout() async {
    globalLoaderCubit.show();
    await authRepository.logout();
    globalLoaderCubit.hide();
    emit(state.copyWith(user: null));
  }

  Future<void> reloadUser() async {
    final user = await authRepository.getUser();
    emit(state.copyWith(user: user));
  }
}
```

## Cubits de Feature

Los Cubits de feature manejan la lógica específica de cada funcionalidad:

### PersonalDataCubit - Datos Personales

Maneja la actualización de datos personales del usuario:

```dart
// lib/src/settings/presentation/profile_info/personal_data/personal_data_cubit.dart
@freezed
abstract class PersonalDataState with _$PersonalDataState {
  factory PersonalDataState({
    required XFile? imageSelected,
    required String imageUrl,
    required String name,
    required String lastName,
    required bool showError,
    required ResultOr<PersonalDataFailure> resultOrPersonalData,
  }) = _PersonalDataState;

  factory PersonalDataState.initial() => _PersonalDataState(
    imageSelected: null,
    imageUrl: '',
    name: '',
    lastName: '',
    showError: false,
    resultOrPersonalData: ResultOr.none(),
  );

  PersonalDataState._();

  // Value Objects para validación
  FullnameVos get nameVos => FullnameVos(name);
  FullnameVos get lastNameVos => FullnameVos(lastName);
}

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit({required this.repository, required this.globalLoaderCubit})
    : super(PersonalDataState.initial());
  
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void init(UserModel? user) {
    emit(state.copyWith(
      name: user?.name ?? '',
      lastName: user?.lastName ?? '',
      imageUrl: user?.profilePhoto ?? '',
    ));
  }

  void changeName(String value) {
    emit(state.copyWith(name: value));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void changeImageSelected(XFile? value) {
    emit(state.copyWith(imageSelected: value));
  }

  Future<void> save() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    
    emit(state.copyWith(resultOrPersonalData: ResultOr.loading()));
    globalLoaderCubit.show();
    
    final result = await repository.updatePersonalData(
      firstName: state.name,
      lastName: state.lastName,
      phone: '',
    );
    
    globalLoaderCubit.hide();
    emit(state.copyWith(resultOrPersonalData: result, showError: true));
    emit(state.copyWith(resultOrPersonalData: ResultOr.none()));
  }

  bool _allFieldsAreValid() => [state.nameVos, state.lastNameVos].areValid;
}
```

### DownloadFileCubit - Descarga de Archivos

Maneja la descarga y gestión de archivos:

```dart
// lib/src/shared/presentation/providers/download_file/download_file_cubit.dart
@freezed
abstract class DownloadFileState with _$DownloadFileState {
  factory DownloadFileState({
    required Resource<DownloadFileFailure, String> resourceGenerateFile,
    required Resource<DownloadFileFailure, String> resourceDownloadFile,
    required Resource<DownloadFileFailure, String> resourceDownloadFileTemp,
  }) = _DownloadFileState;

  factory DownloadFileState.initial() => _DownloadFileState(
    resourceGenerateFile: Resource.none(),
    resourceDownloadFile: Resource.none(),
    resourceDownloadFileTemp: Resource.none(),
  );
}

class DownloadFileCubit extends BaseCubit<DownloadFileState> {
  DownloadFileCubit({required this.downloadFileRepository})
    : super(DownloadFileState.initial());
  
  final IDownloadFileRepository downloadFileRepository;

  Future<void> generateFile(String documentId) async {
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: Resource.loading()));
    final result = await downloadFileRepository.generateFile(documentId);
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: result));
    
    result.whenIsSuccess((url) {
      downloadTemp(url);
    });
  }

  Future<void> downloadTemp(String url) async {
    emitIfNotDisposed(
      state.copyWith(resourceDownloadFileTemp: Resource.loading()),
    );
    final result = await downloadFileRepository.downloadAndSaveFile(
      url,
      isTempFile: true,
    );
    emitIfNotDisposed(state.copyWith(resourceDownloadFileTemp: result));
  }

  Future<void> downloadFileFromUrl() async {
    final documentUrl = state.resourceGenerateFile.whenIsSuccess((url) => url);
    if (documentUrl == null) return;
    
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: Resource.loading()));
    final result = await downloadFileRepository.downloadAndSaveFile(documentUrl);
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: result));
  }
}
```

### MainHomeCubit - Dashboard Principal

Maneja la lógica del dashboard principal:

```dart
// lib/src/home/presentation/providers/main_home_cubit.dart
@freezed
abstract class MainHomeState with _$MainHomeState {
  factory MainHomeState({
    required Resource<GeneralFailure, List<ProductModel>> resourceGetProducts,
  }) = _MainHomeState;

  factory MainHomeState.initial() => _MainHomeState(
    resourceGetProducts: Resource.none(),
  );
}

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit({required this.repository}) : super(MainHomeState.initial());
  
  final IMainHomeRepository repository;

  Future<void> init() async {
    getProducts();
  }

  Future<void> getProducts() async {
    emit(state.copyWith(resourceGetProducts: Resource.loading()));
    final result = await repository.getProducts();
    emit(state.copyWith(resourceGetProducts: result));
  }
}
```

### SplashCubit - Pantalla de Carga

Maneja la lógica de inicialización de la aplicación:

```dart
// lib/src/splash/presentation/providers/splash_cubit.dart
@freezed
abstract class SplashState with _$SplashState {
  factory SplashState({
    required bool splashIsLoaded,
    required bool errorLoading,
    required bool canUpdate,
    required double progressValue,
    required String progressText,
    required String? token,
    required ResultOr<SplashFailure> resultOr,
  }) = _SplashState;

  factory SplashState.initial() => _SplashState(
    splashIsLoaded: false,
    errorLoading: false,
    canUpdate: false,
    progressValue: 0,
    progressText: '',
    token: null,
    resultOr: ResultOr.none(),
  );
}

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required this.settingsCubit,
    required this.authCubit,
    required this.tokenRepository,
  }) : super(SplashState.initial());
  
  final AppSettingsCubit settingsCubit;
  final AuthCubit authCubit;
  final ITokenRepository tokenRepository;

  Future<void> init() async {
    try {
      changeProgressText('Inicializando aplicación');
      
      final appVersionData = await PackageInfo.fromPlatform();
      changeProgressValue(2 / 4);
      
      changeProgressText('Cargando datos de usuario');
      await loadDataUser();
      
      changeProgressValue(4 / 4);
      await Future.delayed(const Duration(milliseconds: 1500));
      changeSplashIsLoaded(true);
    } catch (e) {
      changeErrorLoading(true);
    }
  }

  Future<void> loadDataUser() async {
    final token = await tokenRepository.getToken();
    changeToken(token);
    if (token != null) {
      await authCubit.initUser();
    }
  }

  void changeProgressValue(double value) {
    emitIfNotDisposed(state.copyWith(progressValue: value));
  }

  void changeProgressText(String value) {
    emitIfNotDisposed(state.copyWith(progressText: value));
  }

  void changeSplashIsLoaded(bool value) {
    emitIfNotDisposed(state.copyWith(splashIsLoaded: value));
  }

  void changeErrorLoading(bool value) {
    emitIfNotDisposed(state.copyWith(errorLoading: value));
  }

  void changeToken(String? value) {
    emitIfNotDisposed(state.copyWith(token: value));
  }
}
```

## Ejemplos Reales del Proyecto

### Cubit de Formulario Completo

Ejemplo completo de un Cubit para un formulario de login:

```dart
// lib/src/auth/presentation/signin/providers/signin_cubit.dart
@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required ResultOr<SignInFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  // Value Objects para validación automática
  EmailVos get emailVos => EmailVos(email);
  PasswordVos get passwordVos => PasswordVos(password);
}

class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(SigninState.initial());
  
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void reset() {
    emit(SigninState.initial());
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() => <ValueObject>[
    state.emailVos,
    // state.passwordVos, // Comentado en el proyecto real
  ].areValid;

  void validateEmail() {
    if (state.emailVos.isInvalid()) {
      emit(state.copyWith(showErrors: true));
    } else {
      emit(state.copyWith(showErrors: false));
    }
  }

  Future<void> signin() async {
    if (_allFieldsAreValid()) {
      emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
      globalLoaderCubit.show();
      
      final result = await authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      
      globalLoaderCubit.hide();
      emitIfNotDisposed(state.copyWith(resultOr: result, showErrors: true));
    } else {
      emitIfNotDisposed(state.copyWith(showErrors: true));
    }
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.none()));
  }
}
```

### Cubit con Múltiples Resources

Ejemplo de un Cubit que maneja múltiples operaciones asíncronas:

```dart
// Cubit con múltiples Resources para diferentes operaciones
class ComplexFeatureCubit extends BaseCubit<ComplexFeatureState> {
  ComplexFeatureCubit({
    required this.repository,
    required this.globalLoaderCubit,
  }) : super(ComplexFeatureState.initial());

  final IRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  // Operación que retorna datos
  Future<void> loadData() async {
    emitIfNotDisposed(state.copyWith(
      resourceData: Resource.loading(),
    ));
    
    final result = await repository.getData();
    emitIfNotDisposed(state.copyWith(
      resourceData: result,
    ));
  }

  // Operación que solo indica éxito/error
  Future<void> saveData(Map<String, dynamic> data) async {
    emitIfNotDisposed(state.copyWith(
      resultOrSave: ResultOr.loading(),
    ));
    globalLoaderCubit.show();
    
    final result = await repository.saveData(data);
    globalLoaderCubit.hide();
    emitIfNotDisposed(state.copyWith(
      resultOrSave: result,
    ));
    
    // Reset del resultado después de procesar
    emitIfNotDisposed(state.copyWith(
      resultOrSave: ResultOr.none(),
    ));
  }

  // Operación de descarga de archivo
  Future<void> downloadFile(String fileId) async {
    emitIfNotDisposed(state.copyWith(
      resourceDownload: Resource.loading(),
    ));
    
    final result = await repository.downloadFile(fileId);
    emitIfNotDisposed(state.copyWith(
      resourceDownload: result,
    ));
  }
}

@freezed
abstract class ComplexFeatureState with _$ComplexFeatureState {
  factory ComplexFeatureState({
    required Resource<Failure, List<DataModel>> resourceData,
    required ResultOr<SaveFailure> resultOrSave,
    required Resource<DownloadFailure, String> resourceDownload,
  }) = _ComplexFeatureState;

  factory ComplexFeatureState.initial() => _ComplexFeatureState(
    resourceData: Resource.none(),
    resultOrSave: ResultOr.none(),
    resourceDownload: Resource.none(),
  );
}
```

### Configuración Global en app.dart

La configuración real de los Cubits globales en la aplicación:

```dart
// lib/app.dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Loader global - Siempre primero
        BlocProvider<GlobalLoaderCubit>(
          create: (context) => GlobalLoaderCubit(),
        ),
        
        // Configuraciones de la app
        BlocProvider<AppSettingsCubit>(
          create: (context) => AppSettingsCubit(
            repository: context.read<ISettingsRepository>(),
          ),
        ),
        
        // Tema de la aplicación
        BlocProvider<ThemeModeCubit>(
          create: (context) => ThemeModeCubit(),
        ),
        
        // Idioma de la aplicación
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(
            localeRepository: context.read<ILocaleRepository>(),
          ),
        ),
        
        // Autenticación global
        BlocProvider(
          create: (context) => AuthCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeModeCubit, ThemeModeState>(
      listener: (context, state) {
        // SystemUIHelper.setSystemUIForTheme(state.isDarkMode);
      },
      builder: (context, stateTheme) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, stateLocale) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: appThemeDataLight,
              darkTheme: appThemeDataDark,
              themeMode: stateTheme.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: [
                CustomLocalizationDelegate(stateLocale.locale.languageCode),
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: stateLocale.locale,
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: routerApp,
            );
          },
        );
      },
    );
  }
}
```

### BlocProvider para Cubits Locales

Para Cubits que solo se usan en una pantalla específica:

```dart
// Pantalla de perfil con Cubit local
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: BlocProvider(
        create: (context) => PersonalDataCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        )..init(context.read<AuthCubit>().state.user),
        child: const ProfileForm(),
      ),
    );
  }
}

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDataCubit, PersonalDataState>(
      listener: (context, state) {
        // Listener para efectos secundarios
        state.resultOrPersonalData.whenIsFailure((failure) {
          context.showSnackbarError(failure.message);
        });
        
        state.resultOrPersonalData.whenIsSuccess(() {
          context.showSnackbarSuccess('Datos actualizados correctamente');
          context.read<AuthCubit>().reloadUser(); // Actualizar usuario global
        });
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              initialValue: state.name,
              labelText: 'Nombre',
              onChanged: context.read<PersonalDataCubit>().changeName,
              errorText: state.showError && state.nameVos.isInvalid()
                  ? state.nameVos.value.fold(
                      (failure) => failure.message,
                      (_) => null,
                    )
                  : null,
            ),
            CustomTextField(
              initialValue: state.lastName,
              labelText: 'Apellidos',
              onChanged: context.read<PersonalDataCubit>().changeLastName,
              errorText: state.showError && state.lastNameVos.isInvalid()
                  ? state.lastNameVos.value.fold(
                      (failure) => failure.message,
                      (_) => null,
                    )
                  : null,
            ),
            CustomElevatedButton(
              onPressed: context.read<PersonalDataCubit>().save,
              isLoading: state.resultOrPersonalData.isLoading,
              label: 'Guardar',
            ),
          ],
        );
      },
    );
  }
}
```

### BlocBuilder vs BlocConsumer vs BlocListener

#### BlocBuilder - Solo UI
Para cuando solo necesitas construir UI basada en el estado:

```dart
BlocBuilder<MainHomeCubit, MainHomeState>(
  builder: (context, state) {
    return state.resourceGetProducts.map(
      none: () => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
      success: (products) => ProductsList(products: products),
      failure: (failure) => ErrorWidget(
        message: failure.message,
        onRetry: () => context.read<MainHomeCubit>().getProducts(),
      ),
    );
  },
)
```

#### BlocListener - Solo Efectos Secundarios
Para navegación, snackbars, diálogos:

```dart
BlocListener<SigninCubit, SigninState>(
  listener: (context, state) {
    state.resultOr.whenIsFailure((failure) {
      context.showSnackbarError(failure.message);
    });
    
    state.resultOr.whenIsSuccess(() {
      context.read<AuthCubit>().loginUser();
      context.go('/home');
    });
  },
  child: SigninForm(),
)
```

#### BlocConsumer - UI + Efectos Secundarios
Combina BlocBuilder y BlocListener:

```dart
BlocConsumer<DownloadFileCubit, DownloadFileState>(
  listener: (context, state) {
    // Efectos secundarios
    state.resourceDownloadFile.whenIsSuccess((filePath) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo descargado: $filePath')),
      );
    });
  },
  builder: (context, state) {
    // UI
    return Column(
      children: [
        if (state.resourceDownloadFile.isLoading)
          const LinearProgressIndicator(),
        ElevatedButton(
          onPressed: state.resourceDownloadFile.isLoading
              ? null
              : () => context.read<DownloadFileCubit>().downloadFileFromUrl(),
          child: Text('Descargar'),
        ),
      ],
    );
  },
)
```

### Acceso a Cubits Globales

Los Cubits globales están disponibles en toda la aplicación:

```dart
class AnyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceder a Cubits globales desde cualquier lugar
    final authCubit = context.read<AuthCubit>();
    final localeCubit = context.read<LocaleCubit>();
    final globalLoader = context.read<GlobalLoaderCubit>();
    
    return Column(
      children: [
        // Botón para cambiar idioma
        ElevatedButton(
          onPressed: () => localeCubit.changeLanguage('en'),
          child: Text('Change to English'),
        ),
        
        // Botón para cerrar sesión
        ElevatedButton(
          onPressed: () => authCubit.logout(),
          child: Text('Logout'),
        ),
        
        // Usar estado global para mostrar información
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final user = state.user;
            return user != null
                ? Text('Hola, ${user.name}')
                : Text('No autenticado');
          },
        ),
      ],
    );
  }
}
```

## Integración con UI

### BlocProvider para Cubits Locales

Para Cubits que solo se usan en una pantalla específica:

```dart
// Pantalla de perfil con Cubit local
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: BlocProvider(
        create: (context) => PersonalDataCubit(
          repository: context.read<IPersonalInfoRepository>(),
          globalLoaderCubit: context.read<GlobalLoaderCubit>(),
        )..init(context.read<AuthCubit>().state.user),
        child: const ProfileForm(),
      ),
    );
  }
}

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDataCubit, PersonalDataState>(
      listener: (context, state) {
        // Listener para efectos secundarios
        state.resultOrPersonalData.whenIsFailure((failure) {
          context.showSnackbarError(failure.message);
        });
        
        state.resultOrPersonalData.whenIsSuccess(() {
          context.showSnackbarSuccess('Datos actualizados correctamente');
          context.read<AuthCubit>().reloadUser(); // Actualizar usuario global
        });
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              initialValue: state.name,
              labelText: 'Nombre',
              onChanged: context.read<PersonalDataCubit>().changeName,
              errorText: state.showError && state.nameVos.isInvalid()
                  ? state.nameVos.value.fold(
                      (failure) => failure.message,
                      (_) => null,
                    )
                  : null,
            ),
            CustomTextField(
              initialValue: state.lastName,
              labelText: 'Apellidos',
              onChanged: context.read<PersonalDataCubit>().changeLastName,
              errorText: state.showError && state.lastNameVos.isInvalid()
                  ? state.lastNameVos.value.fold(
                      (failure) => failure.message,
                      (_) => null,
                    )
                  : null,
            ),
            CustomElevatedButton(
              onPressed: context.read<PersonalDataCubit>().save,
              isLoading: state.resultOrPersonalData.isLoading,
              label: 'Guardar',
            ),
          ],
        );
      },
    );
  }
}
```

### BlocBuilder vs BlocConsumer vs BlocListener

#### BlocBuilder - Solo UI
Para cuando solo necesitas construir UI basada en el estado:

```dart
BlocBuilder<MainHomeCubit, MainHomeState>(
  builder: (context, state) {
    return state.resourceGetProducts.map(
      none: () => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
      success: (products) => ProductsList(products: products),
      failure: (failure) => ErrorWidget(
        message: failure.message,
        onRetry: () => context.read<MainHomeCubit>().getProducts(),
      ),
    );
  },
)
```

#### BlocListener - Solo Efectos Secundarios
Para navegación, snackbars, diálogos:

```dart
BlocListener<SigninCubit, SigninState>(
  listener: (context, state) {
    state.resultOr.whenIsFailure((failure) {
      context.showSnackbarError(failure.message);
    });
    
    state.resultOr.whenIsSuccess(() {
      context.read<AuthCubit>().loginUser();
      context.go('/home');
    });
  },
  child: SigninForm(),
)
```

#### BlocConsumer - UI + Efectos Secundarios
Combina BlocBuilder y BlocListener:

```dart
BlocConsumer<DownloadFileCubit, DownloadFileState>(
  listener: (context, state) {
    // Efectos secundarios
    state.resourceDownloadFile.whenIsSuccess((filePath) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo descargado: $filePath')),
      );
    });
  },
  builder: (context, state) {
    // UI
    return Column(
      children: [
        if (state.resourceDownloadFile.isLoading)
          const LinearProgressIndicator(),
        ElevatedButton(
          onPressed: state.resourceDownloadFile.isLoading
              ? null
              : () => context.read<DownloadFileCubit>().downloadFileFromUrl(),
          child: Text('Descargar'),
        ),
      ],
    );
  },
)
```

### Acceso a Cubits Globales

Los Cubits globales están disponibles en toda la aplicación:

```dart
class AnyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceder a Cubits globales desde cualquier lugar
    final authCubit = context.read<AuthCubit>();
    final localeCubit = context.read<LocaleCubit>();
    final globalLoader = context.read<GlobalLoaderCubit>();
    
    return Column(
      children: [
        // Botón para cambiar idioma
        ElevatedButton(
          onPressed: () => localeCubit.changeLanguage('en'),
          child: Text('Change to English'),
        ),
        
        // Botón para cerrar sesión
        ElevatedButton(
          onPressed: () => authCubit.logout(),
          child: Text('Logout'),
        ),
        
        // Usar estado global para mostrar información
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final user = state.user;
            return user != null
                ? Text('Hola, ${user.name}')
                : Text('No autenticado');
          },
        ),
      ],
    );
  }
}
```

## Testing

### Testing Cubits Básicos

Tests para Cubits simples como LocaleCubit:

```dart
// test/locale/locale_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_locale_repository.dart';

void main() {
  group('LocaleCubit', () {
    late LocaleCubit localeCubit;
    late MockILocaleRepository mockLocaleRepository;

    setUp(() {
      mockLocaleRepository = MockILocaleRepository();
      localeCubit = LocaleCubit(localeRepository: mockLocaleRepository);
    });

    tearDown(() {
      localeCubit.close();
    });

    test('initial state has default language code', () {
      expect(localeCubit.state.languageCode, equals('es'));
    });

    blocTest<LocaleCubit, LocaleState>(
      'emits new language code when changeLanguage is called',
      build: () {
        when(mockLocaleRepository.changeLanguageCode(any))
            .thenAnswer((_) async {});
        return localeCubit;
      },
      act: (cubit) => cubit.changeLanguage('en'),
      expect: () => [
        LocaleState(languageCode: 'en'),
      ],
      verify: (_) {
        verify(mockLocaleRepository.changeLanguageCode('en')).called(1);
      },
    );

    blocTest<LocaleCubit, LocaleState>(
      'loads saved locale when loadLocale is called',
      build: () {
        when(mockLocaleRepository.findLanguageCode())
            .thenAnswer((_) async => 'ca');
        return localeCubit;
      },
      act: (cubit) => cubit.loadLocale('es'),
      expect: () => [
        LocaleState(languageCode: 'ca'),
      ],
    );
  });
}
```

### Testing Cubits con Formularios

Tests para Cubits como SigninCubit que manejan formularios:

```dart
// test/auth/signin_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('SigninCubit', () {
    late SigninCubit signinCubit;
    late MockIAuthRepository mockAuthRepository;
    late MockGlobalLoaderCubit mockGlobalLoaderCubit;

    setUp(() {
      mockAuthRepository = MockIAuthRepository();
      mockGlobalLoaderCubit = MockGlobalLoaderCubit();
      signinCubit = SigninCubit(
        authRepository: mockAuthRepository,
        globalLoaderCubit: mockGlobalLoaderCubit,
      );
    });

    tearDown(() {
      signinCubit.close();
    });

    test('initial state is correct', () {
      expect(signinCubit.state, equals(SigninState.initial()));
    });

    blocTest<SigninCubit, SigninState>(
      'updates email when changeEmail is called',
      build: () => signinCubit,
      act: (cubit) => cubit.changeEmail('test@example.com'),
      expect: () => [
        SigninState.initial().copyWith(email: 'test@example.com'),
      ],
    );

    blocTest<SigninCubit, SigninState>(
      'emits loading then success when signin succeeds',
      build: () {
        when(mockAuthRepository.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => ResultOr.success());
        return signinCubit;
      },
      seed: () => SigninState.initial().copyWith(
        email: 'test@example.com',
        password: 'password123',
      ),
      act: (cubit) => cubit.signin(),
      expect: () => [
        SigninState.initial().copyWith(
          email: 'test@example.com',
          password: 'password123',
          resultOr: ResultOr.loading(),
        ),
        SigninState.initial().copyWith(
          email: 'test@example.com',
          password: 'password123',
          resultOr: ResultOr.success(),
          showErrors: true,
        ),
        SigninState.initial().copyWith(
          email: 'test@example.com',
          password: 'password123',
          resultOr: ResultOr.none(),
          showErrors: true,
        ),
      ],
      verify: (_) {
        verify(mockGlobalLoaderCubit.show()).called(1);
        verify(mockGlobalLoaderCubit.hide()).called(1);
      },
    );

    blocTest<SigninCubit, SigninState>(
      'shows errors when fields are invalid',
      build: () => signinCubit,
      seed: () => SigninState.initial().copyWith(
        email: 'invalid-email',
        password: '',
      ),
      act: (cubit) => cubit.signin(),
      expect: () => [
        SigninState.initial().copyWith(
          email: 'invalid-email',
          password: '',
          showErrors: true,
        ),
        SigninState.initial().copyWith(
          email: 'invalid-email',
          password: '',
          showErrors: true,
          resultOr: ResultOr.none(),
        ),
      ],
      verify: (_) {
        verifyNever(mockAuthRepository.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ));
      },
    );
  });
}
```

### Testing Cubits con Resources

Tests para Cubits que usan Resource:

```dart
// test/home/main_home_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('MainHomeCubit', () {
    late MainHomeCubit mainHomeCubit;
    late MockIMainHomeRepository mockRepository;

    setUp(() {
      mockRepository = MockIMainHomeRepository();
      mainHomeCubit = MainHomeCubit(repository: mockRepository);
    });

    tearDown(() {
      mainHomeCubit.close();
    });

    test('initial state has none resources', () {
      expect(
        mainHomeCubit.state.resourceGetProducts,
        equals(Resource.none()),
      );
    });

    blocTest<MainHomeCubit, MainHomeState>(
      'emits loading then success when getProducts succeeds',
      build: () {
        when(mockRepository.getProducts()).thenAnswer(
          (_) async => Resource.success([ProductModel()]),
        );
        return mainHomeCubit;
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        MainHomeState.initial().copyWith(
          resourceGetProducts: Resource.loading(),
        ),
        MainHomeState.initial().copyWith(
          resourceGetProducts: Resource.success([ProductModel()]),
        ),
      ],
    );

    blocTest<MainHomeCubit, MainHomeState>(
      'emits loading then failure when getProducts fails',
      build: () {
        when(mockRepository.getProducts()).thenAnswer(
          (_) async => Resource.failure(GeneralFailure('Network error')),
        );
        return mainHomeCubit;
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        MainHomeState.initial().copyWith(
          resourceGetProducts: Resource.loading(),
        ),
        MainHomeState.initial().copyWith(
          resourceGetProducts: Resource.failure(GeneralFailure('Network error')),
        ),
      ],
    );
  });
}
```

## Mejores Prácticas

### 1. Estados Inmutables con Freezed
```dart
// ✅ Correcto - Usar Freezed para immutabilidad
@freezed
abstract class UserState with _$UserState {
  factory UserState({
    required UserModel? user,
    required bool isLoading,
  }) = _UserState;

  factory UserState.initial() => _UserState(
    user: null,
    isLoading: false,
  );
}

// ❌ Incorrecto - Estado mutable
class UserState {
  UserModel? user;
  bool isLoading;
  
  UserState({this.user, required this.isLoading});
}
```

### 2. Usar BaseCubit Siempre
```dart
// ✅ Correcto - Extender de BaseCubit
class FeatureCubit extends BaseCubit<FeatureState> {
  FeatureCubit() : super(FeatureState.initial());
  
  void updateState(FeatureState newState) {
    emitIfNotDisposed(newState); // Previene memory leaks
  }
}

// ❌ Incorrecto - Extender directamente de Cubit
class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit() : super(FeatureState.initial());
  
  void updateState(FeatureState newState) {
    emit(newState); // Puede causar errores si el Cubit está cerrado
  }
}
```

### 3. Manejar Estados Apropiadamente
```dart
// ✅ Correcto - Usar Resource/ResultOr del proyecto
Future<void> loadData() async {
  emitIfNotDisposed(state.copyWith(resource: Resource.loading()));
  final result = await repository.getData();
  emitIfNotDisposed(state.copyWith(resource: result));
}

// ❌ Incorrecto - Estados primitivos
Future<void> loadData() async {
  emit(state.copyWith(isLoading: true));
  try {
    final data = await repository.getData();
    emit(state.copyWith(isLoading: false, data: data));
  } catch (e) {
    emit(state.copyWith(isLoading: false, error: e.toString()));
  }
}
```

### 4. Value Objects para Validación
```dart
// ✅ Correcto - Usar Value Objects en getters
@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
  }) = _SigninState;

  SigninState._();

  // Getters para validación automática
  EmailVos get emailVos => EmailVos(email);
  PasswordVos get passwordVos => PasswordVos(password);
}

// ❌ Incorrecto - Validación manual en métodos
bool isEmailValid() {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
```

### 5. Reset de Estados Después de Procesar
```dart
// ✅ Correcto - Reset ResultOr después de procesar
Future<void> save() async {
  emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
  final result = await repository.save(data);
  emitIfNotDisposed(state.copyWith(resultOr: result));
  // Reset para permitir nuevas operaciones
  emitIfNotDisposed(state.copyWith(resultOr: ResultOr.none()));
}

// ❌ Incorrecto - No resetear estado
Future<void> save() async {
  emit(state.copyWith(resultOr: ResultOr.loading()));
  final result = await repository.save(data);
  emit(state.copyWith(resultOr: result));
  // Estado queda en success/failure permanentemente
}
```

## Checklist de Gestión de Estado

Al implementar gestión de estado con Cubit:

- [ ] Usar únicamente Cubit (no BLoC ni Provider)
- [ ] Extender siempre de BaseCubit
- [ ] Estados son inmutables usando Freezed
- [ ] Usar emitIfNotDisposed() en lugar de emit()
- [ ] Implementar factory constructors inicial() en estados
- [ ] Usar Resource<F, T> para datos del servidor
- [ ] Usar ResultOr<F> para operaciones sin datos
- [ ] Value Objects en getters para validación
- [ ] Reset de ResultOr después de procesar
- [ ] GlobalLoaderCubit para operaciones asíncronas
- [ ] MultiBlocProvider para Cubits globales en app.dart
- [ ] BlocProvider para Cubits locales de pantalla
- [ ] Tests con bloc_test para cada Cubit
- [ ] Mock de dependencias en tests
- [ ] Documentar estados complejos
- [ ] Dependency injection con GetIt

## BaseCubit

Todos los Cubits del proyecto extienden de `BaseCubit`, que proporciona funcionalidad esencial para prevenir memory leaks:

```dart
// lib/src/shared/presentation/providers/base_cubit.dart
abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  bool isDisposed = false;

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }

  void emitIfNotDisposed(State state) {
    if (!isDisposed) {
      emit(state);
    }
  }
}
```

### Ventajas de BaseCubit

1. **Previene memory leaks**: Evita emitir estados después de dispose
2. **Consistencia**: Todos los Cubits siguen el mismo patrón
3. **Seguridad**: No hay errores por emitir en Cubits cerrados
4. **Debugging**: Facilita el tracking de estados

### Uso Correcto

```dart
// ✅ Correcto - Usar emitIfNotDisposed
class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({required this.authRepository}) : super(SigninState.initial());
  
  Future<void> signin() async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}

// ❌ Incorrecto - Usar emit directamente
class BadCubit extends BaseCubit<SomeState> {
  void updateState() {
    emit(newState); // Puede causar errores si el Cubit está cerrado
  }
}
```

## Patrones de Estado

El proyecto utiliza tres tipos principales de estado con Freezed para inmutabilidad:

### 1. Estados con Resource<F, T>

Para operaciones que requieren datos del servidor con manejo de errores:

```dart
// Estados que usan Resource
@freezed
abstract class MainHomeState with _$MainHomeState {
  factory MainHomeState({
    required Resource<GeneralFailure, List<ProductModel>> resourceGetProducts,
  }) = _MainHomeState;

  factory MainHomeState.initial() => _MainHomeState(
    resourceGetProducts: Resource.none(),
  );
}

// Uso en Cubit
class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit({required this.repository}) : super(MainHomeState.initial());
  
  final IMainHomeRepository repository;

  Future<void> getProducts() async {
    emit(state.copyWith(resourceGetProducts: Resource.loading()));
    final result = await repository.getProducts();
    emit(state.copyWith(resourceGetProducts: result));
  }
}
```

### 2. Estados con ResultOr<F>

Para operaciones que solo necesitan saber éxito/error sin datos:

```dart
// Estados que usan ResultOr
@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required ResultOr<SignInFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  // Getters para Value Objects
  EmailVos get emailVos => EmailVos(email);
  PasswordVos get passwordVos => PasswordVos(password);
}

// Uso en Cubit
class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin() async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
```

### 3. Estados Simples

Para configuraciones y estados simples:

```dart
// Estados simples usando Freezed
@freezed
abstract class LocaleState with _$LocaleState {
  factory LocaleState({
    required String languageCode,
  }) = _LocaleState;

  factory LocaleState.initial() => _LocaleState(
    languageCode: 'es',
  );

  LocaleState._();

  // Getter computado
  Locale get locale => Locale.fromSubtags(languageCode: languageCode);
}

@freezed
abstract class ThemeModeState with _$ThemeModeState {
  factory ThemeModeState({
    required bool isDarkMode,
  }) = _ThemeModeState;

  factory ThemeModeState.initial() => _ThemeModeState(
    isDarkMode: false,
  );
}
```

## Cubits Globales

Los Cubits globales se configuran una vez en la aplicación y están disponibles en todo el árbol de widgets:

### GlobalLoaderCubit - Loader Global

Maneja el overlay de carga global de la aplicación:

```dart
// lib/src/shared/presentation/providers/global_loader/global_loader_cubit.dart
@freezed
abstract class GlobalLoaderState with _$GlobalLoaderState {
  factory GlobalLoaderState({
    required OverlayEntry? globalLoaderEntry,
    required bool hideLoaderOverlayEntry,
  }) = _GlobalLoaderState;

  factory GlobalLoaderState.initial() => _GlobalLoaderState(
    globalLoaderEntry: null,
    hideLoaderOverlayEntry: false,
  );
}

class GlobalLoaderCubit extends Cubit<GlobalLoaderState> {
  GlobalLoaderCubit() : super(GlobalLoaderState.initial());
  bool _globalEntryAdded = false;

  void show() {
    if (_globalEntryAdded) return;
    final context = rootNavigatorKey.currentState?.overlay?.context;
    if (context == null) return;
    OverlayEntry overlayEntry = GlobalCircularProgress.build(context);
    rootNavigatorKey.currentState?.overlay?.insert(overlayEntry);
    _globalEntryAdded = true;
    emit(state.copyWith(globalLoaderEntry: overlayEntry));
  }

  void hide() {
    emit(state.copyWith(hideLoaderOverlayEntry: true));
    Future.delayed(const Duration(milliseconds: 400), () {
      state.globalLoaderEntry?.remove();
      _globalEntryAdded = false;
      emit(state.copyWith(
        hideLoaderOverlayEntry: false,
        globalLoaderEntry: null,
      ));
    });
  }
}

// Uso en otros Cubits
class SigninCubit extends BaseCubit<SigninState> {
  final GlobalLoaderCubit globalLoaderCubit;
  
  Future<void> signin() async {
    globalLoaderCubit.show(); // Mostrar loader
    final result = await authRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    globalLoaderCubit.hide(); // Ocultar loader
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
```

### LocaleCubit - Idioma de la App

Maneja el idioma actual de la aplicación:

```dart
// lib/src/locale/presentation/providers/locale_cubit.dart
@freezed
abstract class LocaleState with _$LocaleState {
  factory LocaleState({
    required String languageCode,
  }) = _LocaleState;

  factory LocaleState.initial() => _LocaleState(
    languageCode: 'es',
  );

  LocaleState._();

  Locale get locale => Locale.fromSubtags(languageCode: languageCode);
}

class LocaleCubit extends Cubit<LocaleState> {
  final ILocaleRepository localeRepository;

  LocaleCubit({required this.localeRepository}) : super(LocaleState.initial());

  Future<void> changeLanguage(String languageCode) async {
    await localeRepository.changeLanguageCode(languageCode);
    emit(state.copyWith(languageCode: languageCode));
  }

  void loadLocale(String languageCode) async {
    final localeLoad = await localeRepository.findLanguageCode();
    if (localeLoad != null) {
      emit(state.copyWith(languageCode: localeLoad));
    } else {
      emit(state.copyWith(languageCode: languageCode));
    }
  }
}
```

### ThemeModeCubit - Tema de la App

Controla el tema claro/oscuro:

```dart
// lib/src/shared/presentation/providers/theme_mode/theme_mode_cubit.dart
@freezed
abstract class ThemeModeState with _$ThemeModeState {
  factory ThemeModeState({
    required bool isDarkMode,
  }) = _ThemeModeState;

  factory ThemeModeState.initial() => _ThemeModeState(
    isDarkMode: false,
  );
}

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeState.initial());

  void toggleTheme() {
    final isDarkMode = !state.isDarkMode;
    changeThemeMode(isDarkMode);
  }

  Future<void> changeThemeMode(bool isDarkMode) async {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}
```

### AuthCubit - Usuario Autenticado

Maneja el estado de autenticación global:

```dart
// lib/src/auth/presentation/providers/auth/auth_cubit.dart
@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required UserModel? user,
  }) = _AuthState;

  factory AuthState.initial() => _AuthState(
    user: null,
  );
}

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;
  
  AuthCubit({required this.authRepository, required this.globalLoaderCubit})
    : super(AuthState.initial());

  Future<void> initUser() async {
    final user = await authRepository.getUser();
    if (user != null && user.document != null) {
      createTokenDevice();
    }
    emit(state.copyWith(user: user));
  }

  Future<void> logout() async {
    globalLoaderCubit.show();
    await authRepository.logout();
    globalLoaderCubit.hide();
    emit(state.copyWith(user: null));
  }

  Future<void> reloadUser() async {
    final user = await authRepository.getUser();
    emit(state.copyWith(user: user));
  }
}
```

## Cubits de Feature

Los Cubits de feature manejan la lógica específica de cada funcionalidad:

### PersonalDataCubit - Datos Personales

Maneja la actualización de datos personales del usuario:

```dart
// lib/src/settings/presentation/profile_info/personal_data/personal_data_cubit.dart
@freezed
abstract class PersonalDataState with _$PersonalDataState {
  factory PersonalDataState({
    required XFile? imageSelected,
    required String imageUrl,
    required String name,
    required String lastName,
    required bool showError,
    required ResultOr<PersonalDataFailure> resultOrPersonalData,
  }) = _PersonalDataState;

  factory PersonalDataState.initial() => _PersonalDataState(
    imageSelected: null,
    imageUrl: '',
    name: '',
    lastName: '',
    showError: false,
    resultOrPersonalData: ResultOr.none(),
  );

  PersonalDataState._();

  // Value Objects para validación
  FullnameVos get nameVos => FullnameVos(name);
  FullnameVos get lastNameVos => FullnameVos(lastName);
}

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit({required this.repository, required this.globalLoaderCubit})
    : super(PersonalDataState.initial());
  
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void init(UserModel? user) {
    emit(state.copyWith(
      name: user?.name ?? '',
      lastName: user?.lastName ?? '',
      imageUrl: user?.profilePhoto ?? '',
    ));
  }

  void changeName(String value) {
    emit(state.copyWith(name: value));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void changeImageSelected(XFile? value) {
    emit(state.copyWith(imageSelected: value));
  }

  Future<void> save() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    
    emit(state.copyWith(resultOrPersonalData: ResultOr.loading()));
    globalLoaderCubit.show();
    
    final result = await repository.updatePersonalData(
      firstName: state.name,
      lastName: state.lastName,
      phone: '',
    );
    
    globalLoaderCubit.hide();
    emit(state.copyWith(resultOrPersonalData: result, showError: true));
    emit(state.copyWith(resultOrPersonalData: ResultOr.none()));
  }

  bool _allFieldsAreValid() => [state.nameVos, state.lastNameVos].areValid;
}
```

### DownloadFileCubit - Descarga de Archivos

Maneja la descarga y gestión de archivos:

```dart
// lib/src/shared/presentation/providers/download_file/download_file_cubit.dart
@freezed
abstract class DownloadFileState with _$DownloadFileState {
  factory DownloadFileState({
    required Resource<DownloadFileFailure, String> resourceGenerateFile,
    required Resource<DownloadFileFailure, String> resourceDownloadFile,
    required Resource<DownloadFileFailure, String> resourceDownloadFileTemp,
  }) = _DownloadFileState;

  factory DownloadFileState.initial() => _DownloadFileState(
    resourceGenerateFile: Resource.none(),
    resourceDownloadFile: Resource.none(),
    resourceDownloadFileTemp: Resource.none(),
  );
}

class DownloadFileCubit extends BaseCubit<DownloadFileState> {
  DownloadFileCubit({required this.downloadFileRepository})
    : super(DownloadFileState.initial());
  
  final IDownloadFileRepository downloadFileRepository;

  Future<void> generateFile(String documentId) async {
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: Resource.loading()));
    final result = await downloadFileRepository.generateFile(documentId);
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: result));
    
    result.whenIsSuccess((url) {
      downloadTemp(url);
    });
  }

  Future<void> downloadTemp(String url) async {
    emitIfNotDisposed(
      state.copyWith(resourceDownloadFileTemp: Resource.loading()),
    );
    final result = await downloadFileRepository.downloadAndSaveFile(
      url,
      isTempFile: true,
    );
    emitIfNotDisposed(state.copyWith(resourceDownloadFileTemp: result));
  }

  Future<void> downloadFileFromUrl() async {
    final documentUrl = state.resourceGenerateFile.whenIsSuccess((url) => url);
    if (documentUrl == null) return;
    
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: Resource.loading()));
    final result = await downloadFileRepository.downloadAndSaveFile(documentUrl);
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: result));
  }
}
```

### MainHomeCubit - Dashboard Principal

Maneja la lógica del dashboard principal:

```dart
// lib/src/home/presentation/providers/main_home_cubit.dart
@freezed
abstract class MainHomeState with _$MainHomeState {
  factory MainHomeState({
    required Resource<GeneralFailure, List<ProductModel>> resourceGetProducts,
  }) = _MainHomeState;

  factory MainHomeState.initial() => _MainHomeState(
    resourceGetProducts: Resource.none(),
  );
}

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit({required this.repository}) : super(MainHomeState.initial());
  
  final IMainHomeRepository repository;

  Future<void> init() async {
    getProducts();
  }

  Future<void> getProducts() async {
    emit(state.copyWith(resourceGetProducts: Resource.loading()));
    final result = await repository.getProducts();
    emit(state.copyWith(resourceGetProducts: result));
  }
}
```

### SplashCubit - Pantalla de Carga

Maneja la lógica de inicialización de la aplicación:

```dart
// lib/src/splash/presentation/providers/splash_cubit.dart
@freezed
abstract class SplashState with _$SplashState {
  factory SplashState({
    required bool splashIsLoaded,
    required bool errorLoading,
    required bool canUpdate,
    required double progressValue,
    required String progressText,
    required String? token,
    required ResultOr<SplashFailure> resultOr,
  }) = _SplashState;

  factory SplashState.initial() => _SplashState(
    splashIsLoaded: false,
    errorLoading: false,
    canUpdate: false,
    progressValue: 0,
    progressText: '',
    token: null,
    resultOr: ResultOr.none(),
  );
}

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required this.settingsCubit,
    required this.authCubit,
    required this.tokenRepository,
  }) : super(SplashState.initial());
  
  final AppSettingsCubit settingsCubit;
  final AuthCubit authCubit;
  final ITokenRepository tokenRepository;

  Future<void> init() async {
    try {
      changeProgressText('Inicializando aplicación');
      
      final appVersionData = await PackageInfo.fromPlatform();
      changeProgressValue(2 / 4);
      
      changeProgressText('Cargando datos de usuario');
      await loadDataUser();
      
      changeProgressValue(4 / 4);
      await Future.delayed(const Duration(milliseconds: 1500));
      changeSplashIsLoaded(true);
    } catch (e) {
      changeErrorLoading(true);
    }
  }

  Future<void> loadDataUser() async {
    final token = await tokenRepository.getToken();
    changeToken(token);
    if (token != null) {
      await authCubit.initUser();
    }
  }

  void changeProgressValue(double value) {
    emitIfNotDisposed(state.copyWith(progressValue: value));
  }

  void changeProgressText(String value) {
    emitIfNotDisposed(state.copyWith(progressText: value));
  }

  void changeSplashIsLoaded(bool value) {
    emitIfNotDisposed(state.copyWith(splashIsLoaded: value));
  }

  void changeErrorLoading(bool value) {
    emitIfNotDisposed(state.copyWith(errorLoading: value));
  }

  void changeToken(String? value) {
    emitIfNotDisposed(state.copyWith(token: value));
  }
}
```

## Ejemplos Reales del Proyecto

### Cubit de Formulario Completo

Ejemplo completo de un Cubit para un formulario de login:

```dart
// lib/src/auth/presentation/signin/providers/signin_cubit.dart
@freezed
abstract class SigninState with _$SigninState {
  factory SigninState({
    required String email,
    required String password,
    required bool showErrors,
    required ResultOr<SignInFailure> resultOr,
  }) = _SigninState;

  factory SigninState.initial() => _SigninState(
    email: '',
    password: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  SigninState._();

  // Value Objects para validación automática
  EmailVos get emailVos => EmailVos(email);
  PasswordVos get passwordVos => PasswordVos(password);
}

class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(SigninState.initial());
  
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void reset() {
    emit(SigninState.initial());
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() => <ValueObject>[
    state.emailVos,
    // state.passwordVos, // Comentado en el proyecto real
  ].areValid;

  void validateEmail() {
    if (state.emailVos.isInvalid()) {
      emit(state.copyWith(showErrors: true));
    } else {
      emit(state.copyWith(showErrors: false));
    }
  }

  Future<void> signin() async {
    if (_allFieldsAreValid()) {
      emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
      globalLoaderCubit.show();
      
      final result = await authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      
      globalLoaderCubit.hide();
      emitIfNotDisposed(state.copyWith(resultOr: result, showErrors: true));
    } else {
      emitIfNotDisposed(state.copyWith(showErrors: true));
    }
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.none()));
  }
}
```

### Cubit con Múltiples Resources

Ejemplo de un Cubit que maneja múltiples operaciones asíncronas:

```dart
// Cubit con múltiples Resources para diferentes operaciones
class ComplexFeatureCubit extends BaseCubit<ComplexFeatureState> {
  ComplexFeatureCubit({
    required this.repository,
    required this.globalLoaderCubit,
  }) : super(ComplexFeatureState.initial());

  final IRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  // Operación que retorna datos
  Future<void> loadData() async {
    emitIfNotDisposed(state.copyWith(
      resourceData: Resource.loading(),
    ));
    
    final result = await repository.getData();
    emitIfNotDisposed(state.copyWith(
      resourceData: result,
    ));
  }

  // Operación que solo indica éxito/error
  Future<void> saveData(Map<String, dynamic> data) async {
    emitIfNotDisposed(state.copyWith(
      resultOrSave: ResultOr.loading(),
    ));
    globalLoaderCubit.show();
    
    final result = await repository.saveData(data);
    globalLoaderCubit.hide();
    emitIfNotDisposed(state.copyWith(
      resultOrSave: result,
    ));
    
    // Reset del resultado después de procesar
    emitIfNotDisposed(state.copyWith(
      resultOrSave: ResultOr.none(),
    ));
  }

  // Operación de descarga de archivo
  Future<void> downloadFile(String fileId) async {
    emitIfNotDisposed(state.copyWith(
      resourceDownload: Resource.loading(),
    ));
    
    final result = await repository.downloadFile(fileId);
    emitIfNotDisposed(state.copyWith(
      resourceDownload: result,
    ));
  }
}

@freezed
abstract class ComplexFeatureState with _$ComplexFeatureState {
  factory ComplexFeatureState({
    required Resource<Failure, List<DataModel>> resourceData,
    required ResultOr<SaveFailure> resultOrSave,
    required Resource<DownloadFailure, String> resourceDownload,
  }) = _ComplexFeatureState;

  factory ComplexFeatureState.initial() => _ComplexFeatureState(
    resourceData: Resource.none(),
    resultOrSave: ResultOr.none(),
    resourceDownload: Resource.none(),
  );
}
```

### Configuración Global en app.dart

La configuración real de los Cubits globales en la aplicación:

```dart
// lib/app.dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Loader global - Siempre primero
        BlocProvider<GlobalLoaderCubit>(
          create: (context) => GlobalLoaderCubit(),
        ),
        
        // Configuraciones de la app
        BlocProvider<AppSettingsCubit>(
          create: (context) => AppSettingsCubit(
            repository: context.read<ISettingsRepository>(),
          ),
        ),
        
        // Tema de la aplicación
        BlocProvider<ThemeModeCubit>(
          create: (context) => ThemeModeCubit(),
        ),
        
        // Idioma de la aplicación
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(
            localeRepository: context.read<ILocaleRepository>(),
          ),
        ),
        
        // Autenticación global
        BlocProvider(
          create: (context) => AuthCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeModeCubit, ThemeModeState>(
      listener: (context, state) {
        // SystemUIHelper.setSystemUIForTheme(state.isDarkMode);
      },
      builder: (context, stateTheme) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, stateLocale) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: appThemeDataLight,
              darkTheme: appThemeDataDark,
              themeMode: stateTheme.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: [
                CustomLocalizationDelegate(stateLocale.locale.languageCode),
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: stateLocale.locale,
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: routerApp,
            );
          },
        );
      },
    );
  }
}
```
