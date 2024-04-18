extension ExtendedList on List {
  List<List<T>> chunked<T>(int countOfChunks) {
    int totalLength = length;
    int chunkSize = totalLength ~/ countOfChunks;
    int leftover = totalLength % countOfChunks;

    List<List<T>> result = [];
    int startIndex = 0;

    for (int i = 0; i < countOfChunks; i++) {
      int currentChunkSize = chunkSize + (i < leftover ? 1 : 0);
      List<T> chunk = List<T>.from(
        sublist(startIndex, startIndex + currentChunkSize),
      );
      result.add(chunk);
      startIndex += currentChunkSize;
    }

    return result;
  }
}
