import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';

class RightAlignedReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const RightAlignedReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<RightAlignedReusableContainer> createState() =>
      _RightAlignedReusableContainerState();
}

class _RightAlignedReusableContainerState
    extends State<RightAlignedReusableContainer> {
  final bool _isFront = true;

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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _buttons(models, context)
          .map(
            (e) => Expanded(child: e),
          )
          .toList(),
    );
  }

  Row _middle(List<List<ReusableModel>> models, BuildContext context) {
    return Row(
      children: [
        if (models.length > 1) Flexible(child: _middleButtons(models, context)),
        Flexible(flex: 2, child: _image()),
      ],
    );
  }

  Column _middleButtons(
      List<List<ReusableModel>> models, BuildContext context) {
    return Column(
      children: _buttons(models[1], context).map((e) {
        return Column(
          children: [
            e,
            const SizedBox(height: 26),
          ],
        );
      }).toList(),
    );
  }

  VehicleObserverImage _image() {
    return VehicleObserverImage(
      key: _imageKey,
      lineDrawer: _lineDrawer,
      image: widget.config.imageView,
      onSideChanged: (isFront) {
        setState(() {
          isFront;
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
    final key = _buttonKeys.firstWhere((element) => element.value == model.id);
    return ReusableContainerButton(
      key: key,
      model: model,
      onModelSelected: widget.onModelSelected,
    );
  }
}
