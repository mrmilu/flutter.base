import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Timer? _timer;

  void run(VoidCallback callback) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(const Duration(seconds: 1), callback);
  }
}

class DebouncerNew {
  Duration? duration;
  VoidCallback? action;
  Timer? _timer;

  DebouncerNew({this.duration});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration ?? const Duration(milliseconds: 300), action);
  }
}
