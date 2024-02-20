import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/extensions/app_error_code_messages.dart';
import 'package:flutter_base/ui/extensions/program_error_messages.dart';

class ErrorMessage extends StatelessWidget {
  // Apply object to errors.
  // ignore: no-object-declaration
  final Object error;
  const ErrorMessage({
    super.key,
    required this.error,
  });

  String _convertErrors() {
    if (error is Error) {
      return (error as Error).getMessage();
    }
    switch (error.runtimeType) {
      case AppError _:
        return (error as AppError).code?.getMessage() ?? '';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = _convertErrors();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            color: Theme.of(context).colorScheme.error,
          ),
          BoxSpacer.h12(),
          Expanded(
            child: Text(
              errorText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
