DateTime getDatetimeByHourAndMinString(String hourAndMinute) {
  final parts = hourAndMinute.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  final second = int.parse(parts[2]);
  final dateTime = DateTime(0, 1, 1, hour, minute, second);
  return dateTime;
}
