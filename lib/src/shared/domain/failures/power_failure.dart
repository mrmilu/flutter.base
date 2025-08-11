abstract class PowerFailure {
  const PowerFailure();
  factory PowerFailure.empty() = PowerFailureEmpty;
  factory PowerFailure.invalid() = PowerFailureInvalid;
  factory PowerFailure.less() = PowerFailureLess;
  factory PowerFailure.more() = PowerFailureMore;

  void when({
    required void Function(PowerFailureEmpty) empty,
    required void Function(PowerFailureInvalid) invalid,
    required void Function(PowerFailureLess) less,
    required void Function(PowerFailureMore) more,
  }) {
    if (this is PowerFailureEmpty) {
      empty.call(this as PowerFailureEmpty);
      return;
    }

    if (this is PowerFailureInvalid) {
      invalid.call(this as PowerFailureInvalid);
      return;
    }

    if (this is PowerFailureLess) {
      less.call(this as PowerFailureLess);
      return;
    }

    if (this is PowerFailureMore) {
      more.call(this as PowerFailureMore);
      return;
    }

    empty.call(this as PowerFailureEmpty);
  }

  R map<R>({
    required R Function(PowerFailureEmpty) empty,
    required R Function(PowerFailureInvalid) invalid,
    required R Function(PowerFailureLess) less,
    required R Function(PowerFailureMore) more,
  }) {
    if (this is PowerFailureEmpty) {
      return empty.call(this as PowerFailureEmpty);
    }

    if (this is PowerFailureInvalid) {
      return invalid.call(this as PowerFailureInvalid);
    }

    if (this is PowerFailureLess) {
      return less.call(this as PowerFailureLess);
    }

    if (this is PowerFailureMore) {
      return more.call(this as PowerFailureMore);
    }

    return empty.call(this as PowerFailureEmpty);
  }

  void maybeWhen({
    void Function(PowerFailureEmpty)? empty,
    void Function(PowerFailureInvalid)? invalid,
    void Function(PowerFailureLess)? less,
    void Function(PowerFailureMore)? more,
    required void Function() orElse,
  }) {
    if (this is PowerFailureEmpty && empty != null) {
      empty.call(this as PowerFailureEmpty);
      return;
    }

    if (this is PowerFailureInvalid && invalid != null) {
      invalid.call(this as PowerFailureInvalid);
      return;
    }

    if (this is PowerFailureLess && less != null) {
      less.call(this as PowerFailureLess);
      return;
    }

    if (this is PowerFailureMore && more != null) {
      more.call(this as PowerFailureMore);
      return;
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(PowerFailureEmpty)? empty,
    R Function(PowerFailureInvalid)? invalid,
    R Function(PowerFailureLess)? less,
    R Function(PowerFailureMore)? more,
    required R Function() orElse,
  }) {
    if (this is PowerFailureEmpty && empty != null) {
      return empty.call(this as PowerFailureEmpty);
    }

    if (this is PowerFailureInvalid && invalid != null) {
      return invalid.call(this as PowerFailureInvalid);
    }

    if (this is PowerFailureLess && less != null) {
      return less.call(this as PowerFailureLess);
    }

    if (this is PowerFailureMore && more != null) {
      return more.call(this as PowerFailureMore);
    }

    return orElse.call();
  }

  factory PowerFailure.fromString(String value) {
    if (value == 'empty') {
      return PowerFailure.empty();
    }

    if (value == 'invalid') {
      return PowerFailure.invalid();
    }

    if (value == 'less') {
      return PowerFailure.less();
    }

    if (value == 'more') {
      return PowerFailure.more();
    }

    return PowerFailure.empty();
  }

  @override
  String toString() {
    if (this is PowerFailureEmpty) {
      return 'empty';
    }

    if (this is PowerFailureInvalid) {
      return 'invalid';
    }

    if (this is PowerFailureLess) {
      return 'less';
    }

    if (this is PowerFailureMore) {
      return 'more';
    }

    return 'empty';
  }
}

class PowerFailureEmpty extends PowerFailure {}

class PowerFailureInvalid extends PowerFailure {}

class PowerFailureLess extends PowerFailure {}

class PowerFailureMore extends PowerFailure {}
