import 'package:collection/collection.dart';

enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhereOrNull((type) => type.toString().split(".").last == value);
}