import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/reusable_container_button.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_observer_image.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';

enum _Position {
  top,
  bottom,
}

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

  late final _buttonKeys = widget.config.models
      .map((e) => GlobalObjectKey(e.id))
      .toList(growable: false);

  final _imageKey = GlobalKey();

  late final _lineDrawer = VehicleLinesDrawer(
    buttonKeys: _buttonKeys,
    imageKey: _imageKey,
  );

  List<List<ReusableModel>> get _models {
    final points = _isFront
        ? widget.config.imageView.imageFrontMarkup
        : widget.config.imageView.imageBackMarkup;
    final top = points
            ?.where((element) => element.position == IDPPointPosition.top)
            .toList() ??
        [];
    final bottom = points
            ?.where((element) => element.position == IDPPointPosition.bottom)
            .toList() ??
        [];
    final withoutPosition =
        points?.where((element) => element.position == null).toList() ?? [];

    final topModels = widget.config.models
        .where((element) => top.any((point) => point.parentID == element.id))
        .toList();
    final bottomModels = widget.config.models
        .where((element) => bottom.any((point) => point.parentID == element.id))
        .toList();
    final withoutPositionModels = widget.config.models
        .where((element) =>
            withoutPosition.any((point) => point.parentID == element.id))
        .toList();

    List<List<ReusableModel>> chunk = withoutPositionModels.chunked(2);
    if (chunk.length == 2) {
      topModels.addAll(chunk[0]);
      bottomModels.addAll(chunk[1]);
    } else {
      topModels.addAll(withoutPositionModels);
    }

    return [topModels, bottomModels];
  }

  @override
  Widget build(BuildContext context) {
    final models = _models;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (models.isNotEmpty) _buttons(models[0], context, _Position.top),
        const SizedBox(height: 10),
        _image(),
        const SizedBox(height: 10),
        if (models.length > 1) _buttons(models[1], context, _Position.bottom),
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

  Widget _buttons(
    List<ReusableModel> models,
    BuildContext context,
    _Position position,
  ) {
    return Row(
      crossAxisAlignment: position == _Position.top
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final button in models) _button(button, context, position),
      ],
    );
  }

  Widget _button(
    ReusableModel model,
    BuildContext context,
    _Position position,
  ) {
    final key = _buttonKeys.firstWhere((element) => element.value == model.id);

    return Expanded(
      child: ReusableContainerButton(
        key: key,
        model: model,
        onModelSelected: widget.onModelSelected,
        isTitleAtBottom: position == _Position.bottom,
      ),
    );
  }
}
