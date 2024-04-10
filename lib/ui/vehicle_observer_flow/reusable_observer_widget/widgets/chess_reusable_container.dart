import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';

class ChessReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const ChessReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<List<IDPIcon?>> chunked = config.buttons.chunked(3);
    List<List<ReusableModel>> models = config.models.chunked(3);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (chunked.isNotEmpty)
          _buttons(chunked[0], models[0], context,
              MainAxisAlignment.spaceBetween, 0),
        const SizedBox(height: 10),
        Image.network(config.imageView.imageFront.url),
        const SizedBox(height: 10),
        if (chunked.length > 1)
          _buttons(
              chunked[1], models[1], context, MainAxisAlignment.center, 16),
        const SizedBox(height: 10),
        if (chunked.length > 2)
          _buttons(
              chunked[2], models[2], context, MainAxisAlignment.spaceBetween, 0,
              needSpacer: true),
      ],
    );
  }

  Widget _buttons(List<IDPIcon?> chunked, List<ReusableModel> models,
      BuildContext context, MainAxisAlignment mainAxisAlignment, double space,
      {bool needSpacer = false}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (needSpacer) const Spacer(),
        for (final button in chunked) ...{
          SizedBox(width: space),
          _button(button, models[chunked.indexOf(button)], context),
          SizedBox(width: space),
        },
        if (needSpacer) const Spacer(),
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
