import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/ui/lib/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/lib/loadable.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/configuration_observer/configuration_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';

class ConfigurationObserverScreen extends StatefulWidget {
  final ConfigurationObserverViewModel viewModel;

  const ConfigurationObserverScreen({super.key, required this.viewModel});

  @override
  State<ConfigurationObserverScreen> createState() =>
      _ConfigurationObserverScreenState();
}

class _ConfigurationObserverScreenState
    extends State<ConfigurationObserverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        decoration: appGradientBgDecoration,
        child: StreamBuilder<Configuration>(
          stream: widget.viewModel.configuration,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _body(snapshot.data!);
            } else {
              return Loadable(forceLoad: true, child: Container());
            }
          },
        ),
      ),
    );
  }

  Widget _body(Configuration data) {
    final models = data.children
        .map((e) => ReusableModel(id: e.id, name: e.name))
        .toList();

    final config = ReusableObserverWidgetConfig(
      imageView: data.imageView,
      buttons: data.children.map((e) => e.image).toList(),
      models: models,
    );

    return ReusableObserverWidget(config: config);
  }
}
