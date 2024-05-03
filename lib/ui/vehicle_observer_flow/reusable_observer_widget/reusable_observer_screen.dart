import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/bottom_reusable_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/chess_reusable_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/left_aligned_reusable_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/right_aligned_reusable_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/top_and_bottom_reusable_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vertical_left_aligned_container.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vertical_right_aligned_container.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';

class ReusableModel {
  final String id;
  final String name;
  final IDPIcon? icon;
  Color? color;
  Color? textColor;

  ReusableModel({
    required this.id,
    required this.name,
    required this.icon,
    this.color,
    this.textColor,
  });
}

class ReusableObserverWidgetConfig {
  final IDPImageView imageView;
  final List<ReusableModel> models;
  final Function(ReusableModel) onModelSelected;

  ReusableObserverWidgetConfig({
    required this.imageView,
    required this.models,
    required this.onModelSelected,
  });
}

class ReusableObserverWidget extends StatefulWidget {
  final ReusableObserverWidgetConfig config;

  const ReusableObserverWidget({super.key, required this.config});

  @override
  State<ReusableObserverWidget> createState() => _ReusableObserverWidgetState();
}

class _ReusableObserverWidgetState extends State<ReusableObserverWidget>
    with TickerProviderStateMixin {
  late final _animationController = GifController(vsync: this);
  String? get _preview => widget.config.imageView.preview?.url;
  late bool _isPreviewProgress = _preview != null;

  @override
  void initState() {
    super.initState();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          _isPreviewProgress = !_isPreviewProgress;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.removeStatusListener((status) {});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _content(_isPreviewProgress, _gif()),
        _content(!_isPreviewProgress, _body()),
      ],
    );
  }

  Widget _content(bool isVisible, Widget child) {
    return Visibility(
      visible: isVisible,
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      child: child,
    );
  }

  Widget _gif() {
    return Gif(
      image: NetworkImage(_preview ?? ''),
      controller: _animationController,
      autostart: Autostart.once,
      placeholder: (context) => const Loadable(
        forceLoad: true,
        child: SizedBox(height: 40, width: 40),
      ),
      onFetchCompleted: () {},
    );
  }

  Widget _body() {
    switch (widget.config.imageView.buttonsTemplate) {
      case ButtonsPosition.bottom:
        return BottomReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.verticalLeft:
        return VerticalLeftAlignedReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.verticalRight:
        return VerticalRightAlignedReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.chess:
        return ChessReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.topAndBottom:
        return TopAndBottomReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.right:
        return RightAlignedReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      case ButtonsPosition.left:
        return LeftAlignedReusableContainer(
          config: widget.config,
          onModelSelected: widget.config.onModelSelected,
        );
      default:
        return Container();
    }
  }
}
