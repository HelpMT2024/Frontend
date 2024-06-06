import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';

class SettingsScreenViewModel with ViewModelErrorHandable {
  final ProfileProvider provider;

  SettingsScreenViewModel({required this.provider});

  void resetPassword() {}

  void changeLanguage() {}

  void subscription() {}

  void privacyPolicy() {}

  void deleteProfile() {}

  void logout() {}
}
