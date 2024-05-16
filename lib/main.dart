import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

import 'services/router/auth_router.dart';
import 'services/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesWrapper.processInitialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help My Truck',
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(textTheme()),
        cupertinoOverrideTheme: CupertinoThemeData(
            barBackgroundColor: ColorConstants.surfacePrimaryDark),
      ),
      initialRoute: SharedPreferencesWrapper.getToken() == null
          ? AuthRouteKeys.welcomeScreen
          : VehicleSelectorRouteKeys.truckSelector,
      onGenerateRoute: AppRouter,
    );
  }
}
