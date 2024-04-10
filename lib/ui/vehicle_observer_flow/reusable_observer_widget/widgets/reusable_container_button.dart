import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';

class ReusableContainerButton extends StatelessWidget {
  final IDPIcon? button;
  final ReusableModel model;
  final Function(ReusableModel) onModelSelected;

  const ReusableContainerButton({
    super.key,
    required this.button,
    required this.model,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return PlatformTextButton(
      onPressed: () => onModelSelected(model),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (button != null) _text(model, styles),
          if (button == null) _container(_text(model, styles)),
          const SizedBox(height: 8),
          if (button != null)
            _container(
              button?.contentType == 'image/svg+xml'
                  ? SvgPicture.network(button!.url)
                  : Image.network(button!.url),
            ),
        ],
      ),
    );
  }

  Text _text(ReusableModel model, TextTheme styles) {
    return Text(
      model.name,
      textAlign: TextAlign.center,
      style: styles.labelMedium!.copyWith(
        color: ColorConstants.surfaceWhite,
      ),
    );
  }

  Container _container(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.onSurfacePrimary,
      ),
      child: child,
    );
  }
}
