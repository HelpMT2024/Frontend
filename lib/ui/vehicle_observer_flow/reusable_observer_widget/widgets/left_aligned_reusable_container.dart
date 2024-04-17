import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';

class LeftAlignedReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const LeftAlignedReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<LeftAlignedReusableContainer> createState() =>
      _LeftAlignedReusableContainerState();
}

class _LeftAlignedReusableContainerState
    extends State<LeftAlignedReusableContainer> {
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
        if (models.isNotEmpty) _line(models[0], context),
        const SizedBox(height: 8),
        _middle(models, context),
        const SizedBox(height: 8),
        if (models.length > 2) _line(models[2], context),
      ],
    );
  }

  Row _line(
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      children: _buttons(models, context)
          .map(
            (e) => Expanded(child: e),
          )
          .toList(),
    );
  }

  Row _middle(
    List<List<ReusableModel>> models,
    BuildContext context,
  ) {
    return Row(
      children: [
        Flexible(flex: 2, child: _image()),
        if (models.length > 1)
          Flexible(
            child: Column(children: _buttons(models[1], context)),
          ),
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

  List<Widget> _buttons(
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return models.map((button) {
      return _button(button, context);
    }).toList();
  }

  Widget _button(ReusableModel model, BuildContext context) {
    return ReusableContainerButton(
      model: model,
      onModelSelected: widget.onModelSelected,
    );
  }
}
