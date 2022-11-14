import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

EdgeInsets textFieldScrollPadding({BuildContext? context}) {
  BuildContext? buildContext = context ??
      GetIt.I.get<GlobalKey<ScaffoldMessengerState>>().currentContext;
  double keyboardHeight =
      buildContext != null ? MediaQuery.of(buildContext).viewInsets.bottom : 0;
  double scrollPadding = keyboardHeight + 20;
  return EdgeInsets.only(bottom: scrollPadding, top: scrollPadding);
}
