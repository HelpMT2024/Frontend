import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_observer_helper.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';

class VerticalLeftAlignedReusableContainer extends StatefulWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const VerticalLeftAlignedReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  State<VerticalLeftAlignedReusableContainer> createState() =>
      _VerticalLeftAlignedReusableContainerState();
}

class _VerticalLeftAlignedReusableContainerState
    extends State<VerticalLeftAlignedReusableContainer> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _middle(widget.config.models, context),
      ],
    );
  }

  Row _middle(List<ReusableModel> models, BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _image()),
        Flexible(
          child: Column(children: _buttons(models, context)),
        ),
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

  List<Widget> _buttons(List<ReusableModel> models, BuildContext context) {
    final filtered = ReusableObserverHelper.getReusableObserverHelperModel(
      config: widget.config,
      chunkSize: 1,
      isFront: _isFront,
    );

    if (filtered.isEmpty) {
      return [];
    }

    return filtered[0].map((button) {
      return Column(
        children: [
          _button(button, context),
          const SizedBox(height: 12),
        ],
      );
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
