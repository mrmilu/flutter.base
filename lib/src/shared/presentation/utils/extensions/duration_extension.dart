extension DurationExtension on Duration {
  String toTimeString() {
    final ms = inMilliseconds;

    var seconds = ms ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '''${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString''';

    return formattedTime;
  }

  String toMinutesString() {
    return '${_twoDigits(inMinutes.remainder(60))}:${_twoDigits(inSeconds.remainder(60))}';
  }

  String _twoDigits(int n) => n >= 10 ? '$n' : '0$n';
}
