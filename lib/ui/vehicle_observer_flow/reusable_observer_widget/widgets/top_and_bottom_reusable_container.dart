import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';

class TopAndBottomReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const TopAndBottomReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<TopAndBottomReusableContainer> createState() =>
      _TopAndBottomReusableContainerState();
}

class _TopAndBottomReusableContainerState
    extends State<TopAndBottomReusableContainer> {
  bool _isFront = true;

  @override
  Widget build(BuildContext context) {
    final models = ReusableObserverHelper.getReusableObserverHelperModel(
      config: widget.config,
      chunkSize: 2,
      isFront: _isFront,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (models.isNotEmpty) _buttons(models[0], context),
        const SizedBox(height: 10),
        _image(),
        const SizedBox(height: 10),
        if (models.length > 1) _buttons(models[1], context),
      ],
    );
  }

  VehicleObserverImage _image() {
    return VehicleObserverImage(
      image: widget.config.imageView,
      onSideChanged: (isFront) {
        setState(() {
          _isFront = isFront;
        });
      },
    );
  }

  Widget _buttons(
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final button in models) _button(button, context),
      ],
    );
  }

  Widget _button(ReusableModel model, BuildContext context) {
    return Expanded(
      child: ReusableContainerButton(
        model: model,
        onModelSelected: widget.onModelSelected,
      ),
    );
  }
}
