extension NullExtension on Object? {
  R map<R>({
    required R Function() isNull,
    required R Function() isNotNull,
  }) {
    if (this == null) {
      return isNull.call();
    }

    return isNotNull.call();
  }

  R? mapOrNull<R>(R Function() isNotNull) {
    if (this == null) {
      return null;
    }

    return isNotNull.call();
  }

  void when({
    required void Function() isNull,
    required void Function() isNotNull,
  }) {
    if (this == null) {
      return isNull.call();
    }

    isNotNull.call();
  }

  void whenIsNotNull(void Function() isNotNull) {
    if (this != null) {
      isNotNull.call();
    }
  }

  void whenIsNull(void Function() isNull) {
    if (this == null) {
      isNull.call();
    }
  }

  bool get isNull => this == null;

  bool get isNotNull => this != null;
}
