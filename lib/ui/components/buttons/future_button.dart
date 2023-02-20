import 'dart:async';

import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Widget Function(bool isLoading) childBuilder;
  final FutureOr Function()? onPressed;
  final bool disableWhenIsLoading;

  const FutureButton({
    super.key,
    this.onPressed,
    required this.childBuilder,
    this.disableWhenIsLoading = true,
  });

  @override
  State<FutureButton> createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.disableWhenIsLoading && isLoading ? null : _onPressed,
      child: widget.childBuilder.call(isLoading),
    );
  }

  Future<void> _onPressed() async {
    setState(() {
      isLoading = true;
    });
    try {
      await widget.onPressed?.call();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
