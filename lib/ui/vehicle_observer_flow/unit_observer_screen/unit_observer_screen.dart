import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/ui/lib/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/lib/loadable.dart';
import 'package:help_my_truck/ui/lib/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/unit_observer_screen/unit_observer_view_model.dart';

class UnitObserverScreen extends StatefulWidget {
  final UnitObserverViewModel viewModel;
  const UnitObserverScreen({super.key, required this.viewModel});

  @override
  State<UnitObserverScreen> createState() => _UnitObserverScreenState();
}

class _UnitObserverScreenState extends State<UnitObserverScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: widget.viewModel.config.name,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        decoration: appGradientBgDecoration,
        child: StreamBuilder<Unit>(
          stream: widget.viewModel.unit,
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

  Widget _body(Unit data) {
    final models = data.children
        .map((e) => ReusableModel(id: e.id, name: e.name))
        .toList();

    final config = ReusableObserverWidgetConfig(
      imageView: data.imageView,
      buttons: data.children.map((e) => e.image).toList(),
      models: models,
      onModelSelected: (model) => widget.viewModel.onModelSelected(
        model.id,
        context,
      ),
    );

    return ReusableObserverWidget(config: config);
  }
}
