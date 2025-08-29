import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';

class ResendEmailCounterWidget extends StatefulWidget {
  const ResendEmailCounterWidget({
    super.key,
    required this.text,
    this.textInTimer,
    required this.onTap,
    this.seconds = 90,
  });
  final String text;
  final String? textInTimer;
  final VoidCallback onTap;
  final int seconds;

  @override
  State<ResendEmailCounterWidget> createState() =>
      _ResendEmailCounterWidgetState();
}

class _ResendEmailCounterWidgetState extends State<ResendEmailCounterWidget> {
  int secondsLeft = 0;
  Timer? _timer;

  void _startCounter() {
    setState(() {
      secondsLeft = widget.seconds;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 1) {
        setState(() {
          secondsLeft--;
        });
      } else {
        setState(() {
          secondsLeft = 0;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextButton.secondary(
          label: secondsLeft == 0
              ? widget.text
              : widget.textInTimer ?? widget.text,
          // enabled: secondsLeft == 0,
          onPressed: secondsLeft == 0
              ? () {
                  widget.onTap();
                  _startCounter();
                }
              : () {},
        ),
        const SizedBox(width: 8),
        if (secondsLeft > 0)
          Text(
            '(${secondsLeft}s)',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }
}
