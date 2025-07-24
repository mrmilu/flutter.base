import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page platformPage(
  Widget child, {
  bool fullscreenDialog = false,
  bool maintainState = false,
  GoRouterState? state,
}) => Platform.isIOS
    ? CupertinoPage(
        key: state?.pageKey,
        name: state?.name,
        child: child,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
      )
    : MaterialPage(
        child: child,
        key: state?.pageKey,
        name: state?.name,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
      );

CustomTransitionPage<void> fadeTransitionPage(
  GoRouterState state,
  Widget page,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    child: page,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) => FadeTransition(opacity: animation, child: child),
  );
}
