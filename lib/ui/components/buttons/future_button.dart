import 'dart:async';

import 'package:flutter/material.dart';

/// [FutureButton] is a button which self-disable when the future provided is loading.
///
/// If you want change de child when is loading the future, you can use [childBuilder] which has a boolean with the loading state of the future.
///
/// [disableWhenIsLoading] is default true. If it's false, the button will not disable when the future is loading.
///
/// [onPressed] could be a Future or a [T] type. If it's not a future, the button will not disable and isLoading always will be false.
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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
