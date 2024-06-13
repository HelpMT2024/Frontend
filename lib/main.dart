import 'dart:io';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/purchase_service.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'firebase_options.dart';

import 'services/router/auth_router.dart';
import 'services/router/router.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class ProxiedHttpOverrides extends HttpOverrides {
  final String proxy;
  ProxiedHttpOverrides(this.proxy);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return proxy.isNotEmpty ? "PROXY $proxy;" : 'DIRECT';
      }
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => Platform.isAndroid;
  }
}

const String flavor = String.fromEnvironment('app.flavor');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesWrapper.processInitialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _configurePaymentSDK();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final proxy = SharedPreferencesWrapper.getProxy();
  if (proxy.isNotEmpty) {
    HttpOverrides.global = ProxiedHttpOverrides(proxy);
  }

  final token = SharedPreferencesWrapper.getToken()?.token;
  restAPIService.addBasicAuth(token ?? '');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

Future<void> _configurePaymentSDK() async {
  await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.error);

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration(AppConsts.revenueCatApiKey)
    ..appUserID = null
    ..observerMode = false;

  await Purchases.configure(configuration);

  // For initializing singleton instance of PurchaseService
  PurchaseService.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        checkboxTheme: CheckboxThemeData(
          side: MaterialStateBorderSide.resolveWith((states) {
            return BorderSide(
              color: ColorConstants.onSurfaceWhite,
              width: 2,
            );
          }),
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: SharedPreferencesWrapper.getToken() == null
          ? AuthRouteKeys.welcomeScreen
          : VehicleSelectorRouteKeys.truckSelector,
      onGenerateRoute: AppRouter,
    );
  }
}
