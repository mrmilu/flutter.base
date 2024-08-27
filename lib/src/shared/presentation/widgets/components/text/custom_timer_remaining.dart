import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/mid_text.dart';

class CustomTimerRemaining extends StatefulWidget {
  const CustomTimerRemaining({super.key, required this.endTime});
  final DateTime endTime;

  @override
  State<CustomTimerRemaining> createState() => _CustomTimerRemainingState();
}

class _CustomTimerRemainingState extends State<CustomTimerRemaining> {
  Timer? _timer;
  late int counter;

  @override
  void initState() {
    counter = widget.endTime.difference(DateTime.now()).inSeconds;
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter <= 0) {
        timer.cancel();
        return;
      }
      if (mounted) {
        setState(() {
          counter = widget.endTime.difference(DateTime.now()).inSeconds;
        });
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
    return MidText.m(
      _getTimeRemaining(widget.endTime),
    );
  }

  String _getTimeRemaining(DateTime endTime) {
    final difference = endTime.difference(DateTime.now());
    if (difference.inSeconds <= 0) {
      return '0';
    }
    return '${LocaleKeys.times_minutes.plural(
      difference.inMinutes,
    )} ${LocaleKeys.times_seconds.plural(
      difference.inSeconds % 60,
    )}';
  }
}
