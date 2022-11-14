import 'package:flutter/material.dart';

class FormScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomSheet;

  const FormScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: bottomSheet,
        body: body,
        appBar: appBar,
      ),
    );
  }
}
