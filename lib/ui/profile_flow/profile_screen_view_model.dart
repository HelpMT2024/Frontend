import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProfileScreenViewModel with ViewModelErrorHandable {
  final ProfileProvider provider;

  late final info = BehaviorSubject<bool>.seeded(false);

  UserInfo? userInfo;
  List<Truck> trucks = [];

  ProfileScreenViewModel({required this.provider}) {
    _getInfo();
  }

  void settings() {
    print('<!> settings');
  }

  void _getInfo() async {
    userInfo = await provider.userInfo().catchError((error) {
      print('<!> Error = ${error}');
    });
    final allTrucks = await provider.trucks();
    final selectedTrucks = allTrucks
        .where((a) => userInfo!.truckList.any((b) => b.externalId == a.id));
    trucks.addAll(selectedTrucks);
    info.add(true);
  }
}
