abstract class ResultOr<F> {
  const ResultOr();
  factory ResultOr.none() = _ResultOrNone;
  factory ResultOr.loading() = _ResultOrLoading;
  factory ResultOr.success() = _ResultOrSuccess;
  factory ResultOr.failure(F failure) = _ResultOrFailure;

  bool get isNone => this is _ResultOrNone;
  bool get isLoading => this is _ResultOrLoading;
  bool get isSuccess => this is _ResultOrSuccess;
  bool get isFailure => this is _ResultOrFailure;

  void whenIsFailure(void Function(F failure) isFailure) {
    if (this is _ResultOrFailure) {
      isFailure.call((this as _ResultOrFailure).failure as F);
    }
  }

  void whenIsSuccess(void Function() isSuccess) {
    if (this is _ResultOrSuccess) {
      isSuccess.call();
    }
  }

  void when({
    required void Function() isNone,
    required void Function() isLoading,
    required void Function(F) isFailure,
    required void Function() isSuccess,
  }) {
    if (this is _ResultOrNone) {
      return isNone.call();
    }

    if (this is _ResultOrLoading) {
      return isLoading.call();
    }

    if (this is _ResultOrFailure) {
      return isFailure.call((this as _ResultOrFailure).failure as F);
    }

    if (this is _ResultOrSuccess) {
      return isSuccess.call();
    }

    isNone.call();
  }

  R map<R>({
    required R Function() isNone,
    required R Function() isLoading,
    required R Function(F) isFailure,
    required R Function() isSuccess,
  }) {
    if (this is _ResultOrNone) {
      return isNone.call();
    }

    if (this is _ResultOrLoading) {
      return isLoading.call();
    }

    if (this is _ResultOrFailure) {
      return isFailure.call((this as _ResultOrFailure).failure as F);
    }

    if (this is _ResultOrSuccess) {
      return isSuccess.call();
    }

    return isNone.call();
  }

  void maybeWhen({
    void Function()? isNone,
    void Function()? isLoading,
    void Function(F)? isFailure,
    void Function()? isSuccess,
    required void Function() orElse,
  }) {
    if (this is _ResultOrNone && isNone != null) {
      return isNone.call();
    }

    if (this is _ResultOrLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is _ResultOrFailure && isFailure != null) {
      return isFailure.call((this as _ResultOrFailure).failure as F);
    }

    if (this is _ResultOrSuccess && isSuccess != null) {
      return isSuccess.call();
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function()? isNone,
    R Function()? isLoading,
    R Function(F)? isFailure,
    R Function()? isSuccess,
    required R Function() orElse,
  }) {
    if (this is _ResultOrNone && isNone != null) {
      return isNone.call();
    }

    if (this is _ResultOrLoading && isLoading != null) {
      return isLoading.call();
    }

    if (this is _ResultOrFailure && isFailure != null) {
      return isFailure.call((this as _ResultOrFailure).failure as F);
    }

    if (this is _ResultOrSuccess && isSuccess != null) {
      return isSuccess.call();
    }

    return orElse.call();
  }
}

class _ResultOrNone<F> extends ResultOr<F> {}

class _ResultOrFailure<F> extends ResultOr<F> {
  final F failure;

  _ResultOrFailure(this.failure);
}

class _ResultOrSuccess<F> extends ResultOr<F> {}

class _ResultOrLoading<F> extends ResultOr<F> {}
