import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';

class TopAndBottomReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const TopAndBottomReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<List<IDPIcon?>> chunked = config.buttons.chunked(2);
    List<List<ReusableModel>> models = config.models.chunked(2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (chunked.isNotEmpty) _buttons(chunked[0], models[0], context),
        const SizedBox(height: 10),
        Image.network(config.imageView.imageFront.url),
        const SizedBox(height: 10),
        if (chunked.length > 1) _buttons(chunked[1], models[1], context),
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
