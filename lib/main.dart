import 'package:flutter/material.dart';
import 'package:help_my_truck/consts/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_my_truck/services/router/home_router.dart';

import 'services/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help My Truck',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(textTheme()),
      ),
      initialRoute: HomeRouteKeys.home,
      onGenerateRoute: AppRouter,
    );
  }
}
