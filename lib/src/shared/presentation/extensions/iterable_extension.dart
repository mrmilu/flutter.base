import '../helpers/value_object.dart';

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension IterableOfValueObject on Iterable<ValueObject> {
  bool get areValid => every((element) => element.isValid());
}
