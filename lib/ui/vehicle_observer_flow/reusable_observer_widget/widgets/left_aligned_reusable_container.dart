import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';

class LeftAlignedReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const LeftAlignedReusableContainer({
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
        if (chunked.isNotEmpty) _line(chunked[0], models[0], context),
        const SizedBox(height: 8),
        _middle(chunked, models, context),
        const SizedBox(height: 8),
        if (chunked.length > 2) _line(chunked[2], models[2], context),
      ],
    );
  }

  Row _line(
    List<IDPIcon?> chunked,
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      children: _buttons(chunked, models, context)
          .map((e) => Expanded(child: e))
          .toList(),
    );
  }

  Row _middle(
    List<List<IDPIcon?>> chunked,
    List<List<ReusableModel>> models,
    BuildContext context,
  ) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: VehicleObserverImage(image: config.imageView),
        ),
        if (chunked.length > 1)
          Flexible(
            child: Column(
              children: _buttons(chunked[1], models[1], context),
            ),
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
