import 'package:flutter/material.dart';

class CustomFailureWidget extends StatelessWidget {
  const CustomFailureWidget({
    super.key,
    required this.message,
    this.textButton,
    required this.onTap,
  });
  final String message;
  final String? textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            child: Text(
              textButton ?? 'Retry',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
