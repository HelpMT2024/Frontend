import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/top_and_button_reusable_container.dart';

class ReusableModel {
  final String id;
  final String name;

  ReusableModel({
    required this.id,
    required this.name,
  });
}

class ReusableObserverWidgetConfig {
  final IDPImageView imageView;
  final List<IDPIcon> buttons;
  final List<ReusableModel> models;

  ReusableObserverWidgetConfig({
    required this.imageView,
    required this.buttons,
    required this.models,
  });
}

class ReusableObserverWidget extends StatefulWidget {
  final ReusableObserverWidgetConfig config;

  const ReusableObserverWidget({super.key, required this.config});

  @override
  State<ReusableObserverWidget> createState() => _ReusableObserverWidgetState();
}

class _ReusableObserverWidgetState extends State<ReusableObserverWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.config.imageView.buttonsTemplate) {
      case ButtonsPosition.topAndBottom:
        return TopAndButtonReusableContainer(config: widget.config);
      default:
        return Container();
    }
  }
}
