import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/services/gifs_loader.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/vehicle_point_drawer.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/mesure_size.dart';

enum AnimationState {
  idle,
  leftToRight,
  rightToLeft,
}

class VehicleObserverImage extends StatefulWidget {
  final Function(bool isFron) onSideChanged;
  final IDPImageView image;
  final VehicleLinesDrawer? lineDrawer;

  const VehicleObserverImage({
    super.key,
    required this.image,
    required this.onSideChanged,
    this.lineDrawer,
  });

  @override
  State<VehicleObserverImage> createState() => _VehicleObserverImageState();
}

class _VehicleObserverImageState extends State<VehicleObserverImage>
    with TickerProviderStateMixin {
  late final _leftAnimationController = GifController(vsync: this);
  late final _rightAnimationController = GifController(vsync: this);
  final GlobalKey _imageKey = GlobalKey();

  bool _needHideRight = false;
  bool get isFront =>
      _leftAnimationController.value == 0.0 &&
          _rightAnimationController.value == 1 ||
      _rightAnimationController.value == 0.0 &&
          _leftAnimationController.value == 1.0;

  @override
  void initState() {
    super.initState();

    _leftAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onSideChanged(!isFront);
      }
    });

    _rightAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onSideChanged(!isFront);
      }
    });
  }

  @override
  void dispose() {
    _leftAnimationController.removeStatusListener((status) {});
    _rightAnimationController.removeStatusListener((status) {});
    _leftAnimationController.dispose();
    _rightAnimationController.dispose();
    super.dispose();
  }

  void _nextAnim(bool isLeft, bool isRight) {
    if (_leftAnimationController.isAnimating ||
        _rightAnimationController.isAnimating) {
      return;
    }

    if (isLeft) {
      if (_leftAnimationController.value == 0.0) {
        _leftAnimationController.forward();
        _needHideRight = true;
      }
      if (_rightAnimationController.value == 1.0) {
        _rightAnimationController.value = 0.0;
        _rightAnimationController.reverse();
        _leftAnimationController.value = 1.0;
        _needHideRight = false;
      }
      if (_leftAnimationController.value == 1.0) {
        _rightAnimationController.value = 1.0;
        _needHideRight = false;
        _leftAnimationController.value = 0.0;
        _rightAnimationController.reverse();
      }
    }

    if (isRight) {
      if (_rightAnimationController.value == 0.0) {
        _needHideRight = false;
        _rightAnimationController.forward();
      }
      if (_leftAnimationController.value == 1.0) {
        _leftAnimationController.value = 0.0;
        _needHideRight = true;
        _rightAnimationController.value = 1.0;
        _leftAnimationController.reverse();
      }
      if (_rightAnimationController.value == 1.0) {
        _leftAnimationController.value = 1.0;
        _needHideRight = true;
        _rightAnimationController.value = 0.0;
        _leftAnimationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.image.leftImage != null &&
            widget.image.rightImage != null) ...{
          MeasureSize(
            key: _imageKey,
            onChange: (size) {
              setState(() {});
            },
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children: [
                _gif(
                  widget.image.rightImage!.url,
                  _leftAnimationController,
                  _needHideRight,
                  widget.image.imageFront.url,
                ),
                _gif(
                  widget.image.leftImage!.url,
                  _rightAnimationController,
                  !_needHideRight,
                  widget.image.imageFront.url,
                ),
              ],
            ),
          ),
          _paint(context),
          Align(
            alignment: Alignment.centerLeft,
            child:
                _button(() => _nextAnim(true, false), Icons.arrow_back_ios_new),
          ),
          Align(
            alignment: Alignment.centerRight,
            child:
                _button(() => _nextAnim(false, true), Icons.arrow_forward_ios),
          ),
        } else ...{
          MeasureSize(
            key: _imageKey,
            onChange: (size) {
              setState(() {});
            },
            child: Image.network(
              widget.image.imageFront.url,
              fit: BoxFit.cover,
            ),
          ),
          _paint(context),
        },
      ],
    );
  }

  Widget _paint(BuildContext context) {
    if (widget.lineDrawer == null) {
      return const SizedBox();
    }
    final imageHeight = widget.image.imageFront.height;
    final imageWidth = widget.image.imageFront.width;
    final aspectRatio = imageWidth / imageHeight;

    final renderBox = _imageKey.currentContext?.findRenderObject()
        as MeasureSizeRenderObject?;

    final width = renderBox?.size.width ?? 0;
    final height = width / aspectRatio;

    return CustomPaint(
      size: Size(width, height),
      painter: VehiclePointsDrawer(
        layout: widget.image,
        isFront: !isFront,
        linesDrawer: widget.lineDrawer!,
      ),
    );
  }

  GestureDetector _button(Function() onTap, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          onTap();
        });
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorConstants.gradientPrimary,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, size: 20, color: ColorConstants.surfaceWhite),
      ),
    );
  }

  Visibility _gif(
    String url,
    GifController controller,
    bool needHide,
    String placeholder,
  ) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      maintainInteractivity: true,
      maintainSize: true,
      maintainSemantics: true,
      visible: needHide,
      child: StreamBuilder<ImageProvider>(
        stream: GifsLoader().imageProvider(url).asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return Gif(
            image: snapshot.data!,
            controller: controller,
            autostart: Autostart.no,
            placeholder: (context) => const Loadable(
              forceLoad: true,
              child: SizedBox(height: 40, width: 40),
            ),
            onFetchCompleted: () {},
          );
        },
      ),
    );
  }
}
