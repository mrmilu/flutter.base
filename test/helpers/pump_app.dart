import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/l10n/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ThemeData? theme,
    List<BlocProvider> providers = const [],
  }) async {
    final app = MaterialApp(
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
      home: Scaffold(
        body: widget,
      ),
    );

    await pumpWidget(
      providers.isNotEmpty
          ? MultiBlocProvider(
              providers: providers,
              child: app,
            )
          : app,
    );
  }
}
