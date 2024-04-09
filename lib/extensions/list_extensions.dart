extension ExtendedList on List {
  List<List<T>> chunked<T>(int size) {
    return [
      for (var i = 0; i < length; i += size)
        sublist(i, i + size < length ? i + size : length).cast<T>().toList()
    ];
  }
}
