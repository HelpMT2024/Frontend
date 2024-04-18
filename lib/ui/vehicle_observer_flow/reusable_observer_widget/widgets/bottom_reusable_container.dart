import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';

class BottomReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const BottomReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<BottomReusableContainer> createState() =>
      _BottomReusableContainerState();
}

class _BottomReusableContainerState extends State<BottomReusableContainer> {
  bool _isFront = true;

  late final _buttonKeys = widget.config.models
      .map((e) => GlobalObjectKey(e.id))
      .toList(growable: false);

  final _imageKey = GlobalKey();

  late final _lineDrawer = VehicleLinesDrawer(
    buttonKeys: _buttonKeys,
    imageKey: _imageKey,
  );

  @override
  Widget build(BuildContext context) {
    final models = ReusableObserverHelper.getReusableObserverHelperModel(
      config: widget.config,
      chunkSize: 1,
      isFront: _isFront,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        _image(),
        const SizedBox(height: 10),
        if (widget.config.models.isNotEmpty) _buttons(models[0], context),
      ],
    );
  }

  VehicleObserverImage _image() {
    return VehicleObserverImage(
      key: _imageKey,
      image: widget.config.imageView,
      lineDrawer: _lineDrawer,
      onSideChanged: (isFront) {
        setState(() {
          _isFront = isFront;
        });
      },
    );
  }

  Widget _buttons(List<ReusableModel> models, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final button in models) _button(button, context),
      ],
    );
  }

  Widget _button(ReusableModel model, BuildContext context) {
    final key = _buttonKeys.firstWhere(
      (element) => element.value == model.id,
      orElse: () => GlobalObjectKey(model.id),
    );
    return Expanded(
      child: ReusableContainerButton(
        key: key,
        model: model,
        onModelSelected: widget.onModelSelected,
      ),
    );
  }
}
