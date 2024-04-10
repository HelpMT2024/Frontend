import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';

class BottomReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const BottomReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Image.network(config.imageView.imageFront.url),
        const SizedBox(height: 10),
        if (config.buttons.isNotEmpty)
          _buttons(config.buttons, config.models, context),
      ],
    );
  }

  Widget _buttons(
    List<IDPIcon?> chunked,
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final button in chunked)
          _button(button, models[chunked.indexOf(button)], context),
      ],
    );
  }

  Widget _button(IDPIcon? button, ReusableModel model, BuildContext context) {
    return Expanded(
      child: ReusableContainerButton(
        button: button,
        model: model,
        onModelSelected: onModelSelected,
      ),
    );
  }
}
