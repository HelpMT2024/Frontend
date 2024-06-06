import 'dart:io';

import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/main.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/services/shared_preferences_wrapper.dart';
import 'package:help_my_truck/ui/widgets/text_box_field.dart';
import 'package:rxdart/rxdart.dart';

class TruckSelectorViewModel {
  final VehicleProvider provider;

  late final trucks = BehaviorSubject<List<Truck>>()
    ..addStream(Stream.fromFuture(provider.trucks()));

  int currentTruckIndex = 0;
  int _tapCount = 0;

  TruckSelectorViewModel({
    required this.provider,
  });

  void selectTruck(BuildContext context) {
    final truck = trucks.value.elementAt(currentTruckIndex);

    Navigator.of(context).pushNamed(
      VehicleSelectorRouteKeys.engineSelector,
      arguments: truck,
    );
  }

  void setProxy(BuildContext context) async {
    _tapCount++;

    if (_tapCount % 10 == 0) {
      final controller = TextEditingController();
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Set Proxy'),
          content: TextBoxField(
            onSaved: (_) {},
            controller: controller,
            hintText: 'Proxy',
            title: 'IP',
            validator: (String? value) {
              return null;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                HttpOverrides.global = ProxiedHttpOverrides(controller.text);
                SharedPreferencesWrapper.setProxy(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Set'),
            ),
          ],
        ),
      );
    }
  }
}
