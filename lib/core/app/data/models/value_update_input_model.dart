class ValueUpdate<T> {
  final T? value;
  final bool force;

  const ValueUpdate({
    this.value,
    this.force = false,
  });
}
