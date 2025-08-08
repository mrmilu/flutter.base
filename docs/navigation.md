# Navegación

## Introducción

Flutter Base utiliza **GoRouter** como solución de navegación, proporcionando navegación declarativa, soporte para deep linking, guards de autenticación y gestión avanzada de rutas. Este documento describe la configuración, patrones y mejores prácticas de navegación en el proyecto.

## Tabla de Contenidos

- [Configuración de GoRouter](#configuración-de-gorouter)
- [Estructura de Rutas](#estructura-de-rutas)
- [Navegación Básica](#navegación-básica)
- [Navegación Anidada](#navegación-anidada)
- [Guards de Autenticación](#guards-de-autenticación)
- [Deep Linking](#deep-linking)
- [Observadores de Navegación](#observadores-de-navegación)
- [Mejores Prácticas](#mejores-prácticas)

## Configuración de GoRouter

### Setup Principal

```dart
// app_router.dart
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter routerApp = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  observers: [
    AppRouterObserver(),
    SentryNavigatorObserver(),
    FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
  ],
  routes: <RouteBase>[
    // Definición de rutas
  ],
);
```

### Integración en MaterialApp

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Base',
      routerConfig: routerApp,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // Más configuración...
    );
  }
}
```

## Estructura de Rutas

### Definición de Nombres de Rutas

```dart
// page_names.dart
class PageNames {
  // Auth routes
  static const String splash = 'Splash page';
  static const String initial = 'Initial page';
  static const String signIn = 'Sign in page';
  static const String signUp = 'Sign up page';
  static const String forgotPassword = 'Forgot password page';
  
  // Main routes
  static const String mainHome = 'Main Home page';
  static const String mainTap2 = 'Main Tap2 page';
  static const String mainTap3 = 'Main Tap3 page';
  static const String mainTap4 = 'Main Tap4 page';
  
  // Settings routes
  static const String settingsProfileInfo = 'Settings profile info page';
  static const String profileInfoPersonalData = 'Profile info personal data page';
  static const String profileInfoAccessData = 'Profile info access data page';
  
  // Utility routes
  static const String webView = 'Web view page';
  
  // Modal routes
  static const String modalSelectImage = 'Modal select image';
  static const String modalCameraPermission = 'Modal camera permission';
}
```

### Configuración de Rutas

```dart
final GoRouter routerApp = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    // Splash route
    GoRoute(
      path: '/',
      name: PageNames.splash,
      builder: (context, state) => const SplashPage(),
    ),
    
    // Auth routes
    GoRoute(
      path: '/initial',
      name: PageNames.initial,
      builder: (context, state) => const InitialPage(),
    ),
    GoRoute(
      path: '/sign-in',
      name: PageNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: PageNames.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: PageNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    
    // Main app with bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
      branches: [
        // Home tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: PageNames.mainHome,
              builder: (context, state) => const MainHomePage(),
            ),
          ],
        ),
        
        // Tap2 tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tap2',
              name: PageNames.mainTap2,
              builder: (context, state) => const Tap2Page(),
            ),
          ],
        ),
        
        // Settings tab with nested routes
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: PageNames.settingsProfileInfo,
              builder: (context, state) => const ProfileInfoPage(),
              routes: [
                GoRoute(
                  path: 'personal-data',
                  name: PageNames.profileInfoPersonalData,
                  builder: (context, state) => const PersonalDataPage(),
                ),
                GoRoute(
                  path: 'access-data',
                  name: PageNames.profileInfoAccessData,
                  builder: (context, state) => const AccessDataPage(),
                  routes: [
                    GoRoute(
                      path: 'change-email',
                      name: PageNames.profileInfoAccessDataChangeEmail,
                      builder: (context, state) => const ChangeEmailPage(),
                    ),
                    GoRoute(
                      path: 'change-password',
                      name: PageNames.profileInfoAccessDataChangePassword,
                      builder: (context, state) => const ChangePasswordPage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'config',
                  name: PageNames.profileInfoSettingsConfig,
                  builder: (context, state) => const SettingsConfigPage(),
                ),
                GoRoute(
                  path: 'extra-info',
                  name: PageNames.profileInfoInfoExtra,
                  builder: (context, state) => const InfoExtraPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    
    // Standalone routes
    GoRoute(
      path: '/webview',
      name: PageNames.webView,
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? '';
        final title = state.uri.queryParameters['title'] ?? '';
        return WebViewPage(url: url, title: title);
      },
    ),
  ],
);
```

## Navegación Básica

### Navegación Programática

```dart
// Navegar a una ruta por path
context.go('/home');

// Navegar por nombre
context.goNamed(PageNames.mainHome);

// Push (agregar a la pila)
context.push('/settings/personal-data');

// Push por nombre
context.pushNamed(PageNames.profileInfoPersonalData);

// Replace (reemplazar ruta actual)
context.pushReplacement('/sign-in');

// Replace por nombre
context.pushReplacementNamed(PageNames.signIn);

// Pop (volver atrás)
context.pop();

// Pop con resultado
context.pop(result);

// Ir a ruta y limpiar pila
context.go('/home');
```

### Navegación con Parámetros

```dart
// Definir ruta con parámetros
GoRoute(
  path: '/user/:userId',
  name: 'userProfile',
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserProfilePage(userId: userId);
  },
)

// Navegar con parámetros de path
context.goNamed(
  'userProfile',
  pathParameters: {'userId': '123'},
);

// Navegar con query parameters
context.goNamed(
  PageNames.webView,
  queryParameters: {
    'url': 'https://example.com',
    'title': 'Example Page',
  },
);

// Navegar con objeto extra
context.goNamed(
  PageNames.userProfile,
  extra: UserEntity(id: '123', name: 'John'),
);
```

### Obtener Parámetros

```dart
class UserProfilePage extends StatelessWidget {
  final String? userId;
  
  const UserProfilePage({this.userId, super.key});
  
  @override
  Widget build(BuildContext context) {
    // Obtener parámetros de path
    final userId = GoRouterState.of(context).pathParameters['userId'];
    
    // Obtener query parameters
    final title = GoRouterState.of(context).uri.queryParameters['title'];
    
    // Obtener objeto extra
    final user = GoRouterState.of(context).extra as UserEntity?;
    
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'User Profile')),
      body: Column(
        children: [
          Text('User ID: $userId'),
          if (user != null) Text('User Name: ${user.name}'),
        ],
      ),
    );
  }
}
```

## Navegación Anidada

### StatefulShellRoute para Bottom Navigation

```dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return ScaffoldWithNavigation(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/home',
          name: PageNames.mainHome,
          builder: (context, state) => const MainHomePage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/profile',
          name: PageNames.profile,
          builder: (context, state) => const ProfilePage(),
          routes: [
            // Rutas anidadas mantienen el bottom navigation
            GoRoute(
              path: 'edit',
              name: PageNames.profileEdit,
              builder: (context, state) => const ProfileEditPage(),
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Scaffold con Navegación

```dart
class ScaffoldWithNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavigation({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
```

### Navegación Condicional en Tabs

```dart
void _onTap(BuildContext context, int index) {
  // Si el usuario no está autenticado y trata de ir al perfil
  if (index == 2 && !isUserAuthenticated) {
    context.pushNamed(PageNames.signIn);
    return;
  }
  
  navigationShell.goBranch(index);
}
```

## Guards de Autenticación

### Implementación de Auth Guard

```dart
// guards/auth_guard.dart
String? authGuard(BuildContext context, GoRouterState state) {
  final authProvider = context.read<AuthProvider>();
  
  // Si el usuario no está autenticado
  if (!authProvider.isAuthenticated) {
    return '/sign-in';
  }
  
  // Si el usuario no ha completado el perfil
  if (!authProvider.currentUser?.hasCompletedProfile ?? false) {
    return '/complete-profile';
  }
  
  // Si el usuario no ha verificado el email
  if (!authProvider.currentUser?.isEmailVerified ?? false) {
    return '/verify-email';
  }
  
  // Permitir acceso
  return null;
}
```

### Uso de Guards en Rutas

```dart
GoRoute(
  path: '/protected-route',
  name: PageNames.protectedRoute,
  builder: (context, state) => const ProtectedPage(),
  redirect: authGuard, // Aplicar guard
)

// Para múltiples guards
String? multipleGuards(BuildContext context, GoRouterState state) {
  // Verificar autenticación
  final authResult = authGuard(context, state);
  if (authResult != null) return authResult;
  
  // Verificar permisos específicos
  final permissionResult = permissionGuard(context, state);
  if (permissionResult != null) return permissionResult;
  
  return null;
}
```

### Guard Global

```dart
final GoRouter routerApp = GoRouter(
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    
    // Rutas públicas que no requieren autenticación
    const publicRoutes = [
      '/',
      '/initial',
      '/sign-in',
      '/sign-up',
      '/forgot-password',
    ];
    
    // Si está en una ruta pública, permitir acceso
    if (publicRoutes.contains(state.matchedLocation)) {
      return null;
    }
    
    // Si no está autenticado, redirigir a login
    if (!authProvider.isAuthenticated) {
      return '/sign-in';
    }
    
    return null;
  },
  routes: [
    // Definición de rutas...
  ],
);
```

## Deep Linking

### Configuración para Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme">
    
    <!-- Intent filter para deep links -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https"
              android:host="yourapp.com" />
    </intent-filter>
    
    <!-- Intent filter para custom scheme -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="flutterbase" />
    </intent-filter>
</activity>
```

### Configuración para iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>yourapp.com</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
    <dict>
        <key>CFBundleURLName</key>
        <string>flutterbase</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>flutterbase</string>
        </array>
    </dict>
</array>
```

### Manejo de Deep Links

```dart
// Rutas diseñadas para deep linking
GoRoute(
  path: '/product/:productId',
  name: 'productDetail',
  builder: (context, state) {
    final productId = state.pathParameters['productId']!;
    final category = state.uri.queryParameters['category'];
    
    return ProductDetailPage(
      productId: productId,
      category: category,
    );
  },
)

// URLs que funcionan:
// https://yourapp.com/product/123
// https://yourapp.com/product/123?category=electronics
// flutterbase://product/123
```

### Generar URLs para Compartir

```dart
String generateShareableUrl(String productId, {String? category}) {
  final uri = Uri.parse('https://yourapp.com/product/$productId');
  
  if (category != null) {
    return uri.replace(queryParameters: {'category': category}).toString();
  }
  
  return uri.toString();
}

// Uso
final shareUrl = generateShareableUrl('123', category: 'electronics');
Share.share(shareUrl);
```

## Observadores de Navegación

### Router Observer Personalizado

```dart
// router_observer.dart
class AppRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('📱 Navigation: Pushed ${route.settings.name}');
    _logNavigation('push', route.settings.name);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('📱 Navigation: Popped ${route.settings.name}');
    _logNavigation('pop', route.settings.name);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('📱 Navigation: Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
    _logNavigation('replace', newRoute?.settings.name);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _logNavigation(String action, String? routeName) {
    if (routeName != null) {
      // Log para analytics
      MyAnalyticsHelper.instance.logScreenView(routeName);
      
      // Log para debugging
      debugPrint('🔍 Navigation [$action]: $routeName');
    }
  }
}
```

### Integración con Analytics

```dart
class AnalyticsRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    
    if (route.settings.name != null) {
      // Firebase Analytics
      FirebaseAnalytics.instance.logScreenView(
        screenName: route.settings.name,
      );
      
      // Custom analytics
      MyAnalyticsHelper.instance.trackPageView(
        pageName: route.settings.name!,
        parameters: _extractParameters(route),
      );
    }
  }

  Map<String, dynamic> _extractParameters(Route<dynamic> route) {
    final parameters = <String, dynamic>{};
    
    if (route.settings.arguments != null) {
      parameters['arguments'] = route.settings.arguments.toString();
    }
    
    return parameters;
  }
}
```

## Mejores Prácticas

### 1. Usar Nombres de Rutas

```dart
// ✅ Correcto
context.goNamed(PageNames.userProfile, pathParameters: {'id': userId});

// ❌ Incorrecto
context.go('/user/$userId');
```

### 2. Centralizar Definiciones de Rutas

```dart
// ✅ Correcto - En page_names.dart
class PageNames {
  static const String userProfile = 'user_profile';
}

// ❌ Incorrecto - Strings dispersos
context.goNamed('user_profile');
```

### 3. Manejar Estados de Loading

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.goNamed(PageNames.home);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingWidget();
          }
          
          return const LoginForm();
        },
      ),
    );
  }
}
```

### 4. Validar Parámetros

```dart
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final userId = state.pathParameters['userId'];
    
    if (userId == null || userId.isEmpty) {
      return const ErrorPage(message: 'Invalid user ID');
    }
    
    return UserProfileContent(userId: userId);
  }
}
```

### 5. Usar Guards Apropiadamente

```dart
// ✅ Correcto - Guard específico
String? adminGuard(BuildContext context, GoRouterState state) {
  final user = context.read<AuthProvider>().currentUser;
  return user?.isAdmin == true ? null : '/unauthorized';
}

// ✅ Correcto - Aplicar guard
GoRoute(
  path: '/admin',
  redirect: adminGuard,
  builder: (context, state) => const AdminPage(),
)
```

### 6. Manejar Errores de Navegación

```dart
void safeNavigate(BuildContext context, String routeName) {
  try {
    context.goNamed(routeName);
  } catch (e) {
    debugPrint('Navigation error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigation failed')),
    );
  }
}
```

### 7. Limpiar Recursos en Pop

```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      // Trabajo periódico
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Limpieza adicional si es necesario
        _timer.cancel();
        return true;
      },
      child: Scaffold(
        // Contenido...
      ),
    );
  }
}
```

## Ejemplos Avanzados

### Modal Routes

```dart
// Mostrar modal
void showCustomModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    routeSettings: const RouteSettings(name: PageNames.modalSelectImage),
    builder: (context) => const SelectImageModal(),
  );
}

// Modal con resultado
Future<String?> showSelectOptionModal(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    builder: (context) => const SelectOptionModal(),
  );
}

// Uso
final result = await showSelectOptionModal(context);
if (result != null) {
  // Manejar resultado
}
```

### Navegación Condicional

```dart
void navigateBasedOnUserType(BuildContext context, UserEntity user) {
  switch (user.type) {
    case UserType.admin:
      context.goNamed(PageNames.adminDashboard);
      break;
    case UserType.customer:
      context.goNamed(PageNames.customerDashboard);
      break;
    case UserType.guest:
      context.goNamed(PageNames.guestDashboard);
      break;
  }
}
```

## Checklist de Navegación

Al implementar navegación:

- [ ] Usar GoRouter para toda la navegación
- [ ] Definir nombres de rutas en PageNames
- [ ] Implementar guards apropiados
- [ ] Configurar deep linking cuando sea necesario
- [ ] Agregar observadores para analytics
- [ ] Manejar estados de loading durante navegación
- [ ] Validar parámetros de ruta
- [ ] Limpiar recursos en dispose
- [ ] Usar navegación anidada para bottom navigation
- [ ] Documentar rutas complejas
