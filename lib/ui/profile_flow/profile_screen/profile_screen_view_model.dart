import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/router/profile_router.dart';
import 'package:rxdart/rxdart.dart';

class ProfileScreenViewModel with ViewModelErrorHandable {
  final ProfileProvider provider;

  late final info = BehaviorSubject<bool>.seeded(false);

  UserInfo? userInfo;
  List<Truck> trucks = [];
  List<Engine> engines = [];

  ProfileScreenViewModel({required this.provider}) {
    _getInfo();
  }

  void settings(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileRouteKeys.settingsScreen);
  }

  void editUsername(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      ProfileRouteKeys.editUsernameScreen,
      arguments: userInfo?.username ?? '',
    );

    _getInfo();
  }

  void _getInfo() async {
    trucks = [];
    engines = [];

    userInfo = await provider.userInfo();

    final allTrucks = await provider.trucks();
    final selectedTrucks = allTrucks
        .where((a) => userInfo!.truckList.any((b) => b.externalId == a.id));
    trucks.addAll(selectedTrucks);

    final allEngines = await provider.engines();
    final selectedEngines = allEngines
        .where((a) => userInfo!.truckList.any((b) => b.engineId == a.id));
    engines.addAll(selectedEngines);

    info.add(true);
  }
}
