import 'package:flutter/material.dart';
import 'package:flutter_base/main_dev.dart' as app;
import 'package:flutter_base/ui/features/post/views/posts/post_page.dart';
import 'package:flutter_base/ui/features/profile/views/profile_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Notes about integration test in flutter_base
/// - pumpAndSettle wait for a timeout. This could be because there is some
/// kind of animation that is not finishing and this method waits for all
/// animations to finish. The source of the problem has not been found.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  //WidgetController.hitTestWarningShouldBeFatal = true;

  testWidgets('Flutter Base App', (tester) async {
    await tester.pumpApp();
    await tester.navigateToProfile();
    await tester.navigateToList();
  });
}

/// We use WidgetTester extension to launch app once and organize and different
/// tests in separate functions.
extension on WidgetTester {
  Future<void> pumpApp() async {
    // To fix error: A test override FlutterError.onError but either failed to return it to its original state, or had unexpected additional errors that it could not handle. Typically, this is caused by using expect() before restoring FlutterError.onError.
    // This error is throw if override FlutterError.onError in app and then you use expect() in test.
    final originalOnError = FlutterError.onError!;
    app.main();
    // Time to wait app initialization. If your device need more time, change it.
    await pump(const Duration(seconds: 6));
    FlutterError.onError = originalOnError;
  }

  Future<void> navigateToProfile() async {
    printToConsole('Navigate to profile');
    // TODO find a mechanism to not use keys with hardcode strings
    final profileButton = find.byKey(const Key('bottom-bar-item-1'));
    await tap(profileButton);
    await pump();
    expect(find.byType(ProfilePage), findsOneWidget);
  }

  Future<void> navigateToList() async {
    printToConsole('Navigate to list');
    final listButton = find.byKey(const Key('bottom-bar-item-0'));
    await tap(listButton);
    await pump();
    expect(find.byType(PostPage), findsOneWidget);
  }
}
