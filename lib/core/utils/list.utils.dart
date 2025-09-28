extension ListX<T> on List<T> {
  T? previousOrNull(int index) {
    if (isEmpty || index <= 0 || index >= length - 1) return null;

    return this[index - 1];
  }

  T? nextOrNull(int index) {
    if (isEmpty || index < 0 || index >= length - 1) return null;

    return this[index + 1];
  }
}
