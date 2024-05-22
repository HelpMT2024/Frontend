import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';

class FavoritesScreenViewModel {
  final VehicleProvider provider;

  FavoritesScreenViewModel({required this.provider});

  void favoritesList() {
    
    print(SharedPreferencesWrapper.getToken()?.refreshToken ?? '');
  }

  void change() {

  }

  void user() {

  }
}