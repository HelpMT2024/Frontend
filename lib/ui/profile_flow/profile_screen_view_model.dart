import 'package:help_my_truck/services/API/profile_provider.dart';

class ProfileScreenViewModel {
  final ProfileProvider provider;

  const ProfileScreenViewModel({required this.provider});

  void settings() {
    print('<!> settings');
  }
}
