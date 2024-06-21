import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class GifsLoader {
  BehaviorSubject<double> progress = BehaviorSubject<double>.seeded(0.0);
  final dio = Dio();
  final int maxConcurrentDownloads = 10;

  Future<ImageProvider> imageProvider(String url) async {
    final filePath = await _getFilePath(url);
    final file = File(filePath);

    if (await file.exists()) {
      return FileImage(file);
    } else {
      return NetworkImage(url);
    }
  }

  Future<void> loadList(List<String> list) async {
    final total = list.length;
    var loaded = 0;

    for (int i = 0; i < list.length; i += maxConcurrentDownloads) {
      final subList = list.sublist(
        i,
        i + maxConcurrentDownloads > list.length
            ? list.length
            : i + maxConcurrentDownloads,
      );

      await Future.wait(subList.map((url) => _downloadFile(url)));

      loaded += subList.length;
      progress.add(loaded / total);
    }
  }

  Future<void> _downloadFile(String url) async {
    final filePath = await _getFilePath(url);
    final file = File(filePath);

    if (!await file.exists()) {
      await _saveFile(url, filePath);
    }
  }

  Future<String> _getFilePath(String url) async {
    final directory = await getApplicationCacheDirectory();
    final fileName = Uri.encodeComponent(url);
    return '${directory.path}/$fileName';
  }

  Future<void> _saveFile(String url, String filePath) async {
    final response =
        await dio.get(url, options: Options(responseType: ResponseType.bytes));
    final file = File(filePath);
    await file.writeAsBytes(response.data);
  }
}
