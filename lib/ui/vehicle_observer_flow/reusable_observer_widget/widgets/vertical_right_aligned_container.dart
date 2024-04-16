import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';

class VerticalRightAlignedReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const VerticalRightAlignedReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _middle(config.buttons, config.models, context),
      ],
    );
  }

  Row _middle(
    List<IDPIcon?> chunked,
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      children: [
        Flexible(
          child: Column(
            children: _buttons(chunked, models, context),
          ),
        ),
        Flexible(
          flex: 2,
          child: VehicleObserverImage(image: config.imageView),
        ),
      ],
    );
  }

  List<Widget> _buttons(
    List<IDPIcon?> chunked,
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return chunked.map((button) {
      return _button(button, models[chunked.indexOf(button)], context);
    }).toList();
  }

  Widget _button(IDPIcon? button, ReusableModel model, BuildContext context) {
    return ReusableContainerButton(
      button: button,
      model: model,
      onModelSelected: onModelSelected,
    );
  }
}
