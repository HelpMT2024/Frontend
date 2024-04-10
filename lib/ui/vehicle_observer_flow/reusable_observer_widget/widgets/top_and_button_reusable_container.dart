import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';

class TopAndButtonReusableContainer extends StatelessWidget {
  final Function(ReusableModel) onModelSelected;
  final ReusableObserverWidgetConfig config;

  const TopAndButtonReusableContainer({
    super.key,
    required this.config,
    required this.onModelSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<List<IDPIcon?>> chunked = config.buttons.chunked(2);
    List<List<ReusableModel>> models = config.models.chunked(2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        if (chunked.isNotEmpty) _buttons(chunked[0], models[0], context),
        const SizedBox(height: 10),
        Image.network(config.imageView.imageFront.url),
        const SizedBox(height: 10),
        if (chunked.length > 1) _buttons(chunked[1], models[1], context),
      ],
    );
  }

  Widget _buttons(
    List<IDPIcon?> chunked,
    List<ReusableModel> models,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final button in chunked)
          _button(button, models[chunked.indexOf(button)], context),
      ],
    );
  }

  Widget _button(IDPIcon? button, ReusableModel model, BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Expanded(
      child: PlatformTextButton(
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
                button.contentType == 'image/svg+xml'
                    ? SvgPicture.network(button.url)
                    : Image.network(button.url),
              ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.onSurfacePrimary,
      ),
      child: child,
    );
  }
}
