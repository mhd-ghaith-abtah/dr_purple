class Wrapped<T> {
  final T value;

  const Wrapped.value(this.value);

  @override
  String toString() => "$value";
}
