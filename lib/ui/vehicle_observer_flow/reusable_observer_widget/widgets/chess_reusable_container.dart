import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';

class ChessReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const ChessReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<ChessReusableContainer> createState() => _ChessReusableContainerState();
}

class _ChessReusableContainerState extends State<ChessReusableContainer> {
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
      chunkSize: 3,
      isFront: _isFront,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (models.isNotEmpty)
          _buttons(models[0], context, MainAxisAlignment.spaceBetween, 0),
        const SizedBox(height: 10),
        _image(),
        const SizedBox(height: 10),
        if (models.length > 1)
          _buttons(models[1], context, MainAxisAlignment.center, 16),
        const SizedBox(height: 10),
        if (models.length > 2)
          _buttons(models[2], context, MainAxisAlignment.spaceBetween, 0,
              needSpacer: true),
      ],
    );
  }

  VehicleObserverImage _image() {
    return VehicleObserverImage(
      key: _imageKey,
      lineDrawer: _lineDrawer,
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
    MainAxisAlignment mainAxisAlignment,
    double space, {
    bool needSpacer = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (needSpacer) const Spacer(),
        for (final button in models) ...{
          SizedBox(width: space),
          _button(button, context),
          SizedBox(width: space),
        },
        if (needSpacer) const Spacer(),
      ],
    );
  }

  Widget _button(ReusableModel model, BuildContext context) {
    final key = _buttonKeys.firstWhere((element) => element.value == model.id);
    return Expanded(
      child: ReusableContainerButton(
        key: key,
        model: model,
        onModelSelected: widget.onModelSelected,
      ),
    );
  }
}
