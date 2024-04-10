extension ExtendedList on List {
  List<List<T>> chunked<T>(int size) {
    if (size <= 0) {
      throw ArgumentError('Size must be greater than 0');
    }

    if (isEmpty) {
      return [];
    }

    return [
      for (var i = 0; i < length; i += size)
        sublist(i, i + size < length ? i + size : length).cast<T>().toList()
    ];
  }
}
