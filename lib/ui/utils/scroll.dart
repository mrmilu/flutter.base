import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

EdgeInsets textFieldScrollPadding({BuildContext? context}) {
  final BuildContext? buildContext = context ??
      GetIt.I.get<GlobalKey<ScaffoldMessengerState>>().currentContext;
  final double keyboardHeight =
      buildContext != null ? MediaQuery.of(buildContext).viewInsets.bottom : 0;
  final double scrollPadding = keyboardHeight + 20;
  return EdgeInsets.all(scrollPadding);
}
