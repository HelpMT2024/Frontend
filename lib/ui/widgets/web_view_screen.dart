// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class WebViewScreen extends StatefulWidget {
  final PdfFile pdfFile;

  const WebViewScreen({super.key, required this.pdfFile});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String localPath = '';

  @override
  void initState() {
    _downloadFile();

    super.initState();
  }

  Future<void> _downloadFile() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfFile.url!));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${widget.pdfFile.title}.pdf');
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        localPath = file.path;
      });
    } catch (e) {
      print('Error downloading file: $e');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: widget.pdfFile.title,
      ),
      body: Stack(
        children: [
          Container(decoration: appGradientBgDecoration),
          localPath.isEmpty
              ? Loadable(forceLoad: true, child: Container())
              : PDFView(
                  filePath: localPath,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: false,
                  pageFling: false,
                  onError: (error) {
                    Navigator.of(context).pop();
                  },
                )
        ],
      ),
    );
  }
}
