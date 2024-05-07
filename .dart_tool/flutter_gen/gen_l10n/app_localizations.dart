import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// No description provided for @people_title.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people_title;

  /// No description provided for @fault_code_title.
  ///
  /// In en, this message translates to:
  /// **'Fault Codes'**
  String get fault_code_title;

  /// No description provided for @favorites_title.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites_title;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @spn_number_title.
  ///
  /// In en, this message translates to:
  /// **'SPN Number'**
  String get spn_number_title;

  /// No description provided for @fmi_number_title.
  ///
  /// In en, this message translates to:
  /// **'FMI Number'**
  String get fmi_number_title;

  /// No description provided for @enter_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter \$1'**
  String get enter_hint;

  /// No description provided for @search_fault_code_button.
  ///
  /// In en, this message translates to:
  /// **'Search Fault Code'**
  String get search_fault_code_button;

  /// No description provided for @choose_your_truck.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Truck'**
  String get choose_your_truck;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @choose_your_engine.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Engine'**
  String get choose_your_engine;

  /// No description provided for @instructions_title.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions_title;

  /// No description provided for @comments_title.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments_title;

  /// No description provided for @tips_and_hinst_video.
  ///
  /// In en, this message translates to:
  /// **'Tips & Hints Videos'**
  String get tips_and_hinst_video;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops'**
  String get oops;

  /// No description provided for @no_result_found.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get no_result_found;

  /// No description provided for @no_search_result_description.
  ///
  /// In en, this message translates to:
  /// **'Please try another SPN/FMI code'**
  String get no_search_result_description;

  /// No description provided for @open_page_with_fault_code.
  ///
  /// In en, this message translates to:
  /// **'Page with this Fault Code'**
  String get open_page_with_fault_code;

  /// No description provided for @warning_page_title.
  ///
  /// In en, this message translates to:
  /// **'Warning Lights'**
  String get warning_page_title;

  /// No description provided for @possible_causes.
  ///
  /// In en, this message translates to:
  /// **'Possible Causes:'**
  String get possible_causes;

  /// No description provided for @fault_code_description_title.
  ///
  /// In en, this message translates to:
  /// **'Fault Code Description:'**
  String get fault_code_description_title;

  /// No description provided for @spn_fmi_title.
  ///
  /// In en, this message translates to:
  /// **'SPN/FMI'**
  String get spn_fmi_title;

  /// No description provided for @truck_care_anywhere.
  ///
  /// In en, this message translates to:
  /// **'TRUCK CARE ANYWHERE'**
  String get truck_care_anywhere;

  /// No description provided for @ultimate_maintenance.
  ///
  /// In en, this message translates to:
  /// **'The Ultimate Maintenance and Repair Solution'**
  String get ultimate_maintenance;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @notice.
  ///
  /// In en, this message translates to:
  /// **'*By continuing, you are agreeing to our'**
  String get notice;

  /// No description provided for @terms_button_title.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_button_title;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @create_account_button_title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_account_button_title;

  /// No description provided for @account_exists.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get account_exists;

  /// No description provided for @username_error.
  ///
  /// In en, this message translates to:
  /// **'This username already exists'**
  String get username_error;

  /// No description provided for @email_error.
  ///
  /// In en, this message translates to:
  /// **'This email already exists'**
  String get email_error;

  /// No description provided for @confirm_password_error.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get confirm_password_error;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
