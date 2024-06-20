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
  /// **'Fault Code'**
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

  /// No description provided for @ooops.
  ///
  /// In en, this message translates to:
  /// **'Ooops!'**
  String get ooops;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops..'**
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
  /// **'Sign In'**
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
  /// **'By continuing, you are agreeing to our'**
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
  /// **'Privacy policy'**
  String get privacy_policy;

  /// No description provided for @create_account_button_title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_account_button_title;

  /// No description provided for @account_exists.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
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
  /// **'Passwords do not match'**
  String get confirm_password_error;

  /// No description provided for @account_not_exists.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get account_not_exists;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enter_verification_code;

  /// No description provided for @we_sent_code.
  ///
  /// In en, this message translates to:
  /// **'We sent the code to the email'**
  String get we_sent_code;

  /// No description provided for @enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enter_code;

  /// No description provided for @conti_nue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get conti_nue;

  /// No description provided for @didnt_receive_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didnt_receive_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @recovery_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you instructions to reset password'**
  String get recovery_code;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @deleted_by_admin_error.
  ///
  /// In en, this message translates to:
  /// **'Your account was deleted by the administrator'**
  String get deleted_by_admin_error;

  /// No description provided for @no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_internet_connection;

  /// No description provided for @refresh_error.
  ///
  /// In en, this message translates to:
  /// **'Please reauth into app'**
  String get refresh_error;

  /// No description provided for @password_prompt.
  ///
  /// In en, this message translates to:
  /// **'Your password must contain at least 8 characters'**
  String get password_prompt;

  /// No description provided for @favorites_placeholder_title.
  ///
  /// In en, this message translates to:
  /// **'Start adding important pages to your bookmarks.'**
  String get favorites_placeholder_title;

  /// No description provided for @favorites_placeholder_description.
  ///
  /// In en, this message translates to:
  /// **'They will appear here'**
  String get favorites_placeholder_description;

  /// No description provided for @no_connection_description.
  ///
  /// In en, this message translates to:
  /// **'No internet connection found. Check your connection'**
  String get no_connection_description;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions'**
  String get terms_and_conditions;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @verify_your_email.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verify_your_email;

  /// No description provided for @check_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please check your email and follow the instructions for log in'**
  String get check_your_email;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @favorites_item_type_units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get favorites_item_type_units;

  /// No description provided for @favorites_item_type_systems.
  ///
  /// In en, this message translates to:
  /// **'Systems'**
  String get favorites_item_type_systems;

  /// No description provided for @favorites_item_type_components.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get favorites_item_type_components;

  /// No description provided for @favorites_item_type_parts.
  ///
  /// In en, this message translates to:
  /// **'Parts'**
  String get favorites_item_type_parts;

  /// No description provided for @favorites_item_type_sub_parts.
  ///
  /// In en, this message translates to:
  /// **'Sub Parts'**
  String get favorites_item_type_sub_parts;

  /// No description provided for @favorites_item_type_fault_codes.
  ///
  /// In en, this message translates to:
  /// **'Fault Codes'**
  String get favorites_item_type_fault_codes;

  /// No description provided for @favorites_item_type_problem_cases.
  ///
  /// In en, this message translates to:
  /// **'Problem Cases'**
  String get favorites_item_type_problem_cases;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @your_trucks.
  ///
  /// In en, this message translates to:
  /// **'Your Trucks'**
  String get your_trucks;

  /// No description provided for @engine.
  ///
  /// In en, this message translates to:
  /// **'Engine:'**
  String get engine;

  /// No description provided for @edit_username_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Username'**
  String get edit_username_title;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @legal_and_policies.
  ///
  /// In en, this message translates to:
  /// **'Legal & policies'**
  String get legal_and_policies;

  /// No description provided for @delete_profile.
  ///
  /// In en, this message translates to:
  /// **'Delete profile'**
  String get delete_profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @want_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Logout?'**
  String get want_logout;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @want_delete_profile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete profile?'**
  String get want_delete_profile;

  /// No description provided for @new_password_prompt.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get new_password_prompt;

  /// No description provided for @confirm_password_prompt.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_password_prompt;

  /// No description provided for @save_new_password_title.
  ///
  /// In en, this message translates to:
  /// **'Save New Password'**
  String get save_new_password_title;

  /// No description provided for @enter_password_prompt.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enter_password_prompt;

  /// No description provided for @active_subscription.
  ///
  /// In en, this message translates to:
  /// **'YOUR SUBSCRIPTION IS ACTIVE'**
  String get active_subscription;

  /// No description provided for @inactive_subscription.
  ///
  /// In en, this message translates to:
  /// **'YOUR SUBSCRIPTION IS INACTIVE'**
  String get inactive_subscription;

  /// No description provided for @current_period.
  ///
  /// In en, this message translates to:
  /// **'Current period:'**
  String get current_period;

  /// No description provided for @subscribed_since.
  ///
  /// In en, this message translates to:
  /// **'Subscribed since:'**
  String get subscribed_since;

  /// No description provided for @renews_on.
  ///
  /// In en, this message translates to:
  /// **'Renews on:'**
  String get renews_on;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @restore_purchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restore_purchases;

  /// No description provided for @multiple_subscription.
  ///
  /// In en, this message translates to:
  /// **'Allows you to use your subscription on multiple devices at once'**
  String get multiple_subscription;

  /// No description provided for @annual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get annual;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @free_trial.
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get free_trial;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @collapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapse;

  /// No description provided for @favorites_item_type_configurations.
  ///
  /// In en, this message translates to:
  /// **'Configurations'**
  String get favorites_item_type_configurations;

  /// No description provided for @ago.
  ///
  /// In en, this message translates to:
  /// **'ago'**
  String get ago;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get year;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'weeks'**
  String get weeks;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;
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
