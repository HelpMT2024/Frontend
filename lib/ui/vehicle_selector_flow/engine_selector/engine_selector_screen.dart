import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/engine_selector/engine_selector_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/next_button.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class EngineSelectorScreen extends StatefulWidget {
  final EngineSelectorViewModel viewModel;

  const EngineSelectorScreen({super.key, required this.viewModel});

  @override
  State<EngineSelectorScreen> createState() => _EngineSelectorScreenState();
}

class _EngineSelectorScreenState extends State<EngineSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(context: context, styles: styles),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        decoration: appGradientBgDecoration,
        child: StreamBuilder<List<Engine>>(
          stream: widget.viewModel.engines,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _body(snapshot.data!);
            } else {
              return Loadable(forceLoad: true, child: Container());
            }
          },
        ),
      ),
    );
  }

  Widget _body(List<Engine> data) {
    final styles = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _header(styles),
        const Spacer(),
        if (data.isNotEmpty) _carousel(data),
        _indicator(data),
        const Spacer(),
        _next(),
      ],
    );
  }

  Padding _next() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: NextButton(
        onPressed: () => widget.viewModel.selectEngine(context),
      ),
    );
  }

  PageViewDotIndicator _indicator(List<Engine> data) {
    return PageViewDotIndicator(
      currentItem: widget.viewModel.currentEngineIndex,
      count: data.length,
      size: const Size(8, 8),
      unselectedColor: ColorConstants.surfaceWhite.withOpacity(0.5),
      selectedColor: ColorConstants.surfaceWhite,
    );
  }

  Widget _carousel(List<Engine> data) {
    final styles = Theme.of(context).textTheme;

    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) {
        final truck = data[index];
        print('<!> ${truck.image.url}');
        return Column(
          children: [
            SizedBox(
              height: 240,
              width: 240,
              child: Image.network(truck.image.url),
            ),
            Text(
              truck.name.toUpperCase(),
              style: styles.titleMedium?.copyWith(
                color: ColorConstants.surfaceWhite,
              ),
            ),
          ],
        );
      },
      options: CarouselOptions(
        height: 336,
        onPageChanged: (index, reason) {
          setState(() {
            widget.viewModel.currentEngineIndex = index;
          });
        },
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
        initialPage: 0,
      ),
    );
  }

  Widget _header(TextTheme styles) {
    final l10n = AppLocalizations.of(context);
    return Text(
      l10n!.choose_your_engine,
      style: styles.headlineSmall?.copyWith(
        color: ColorConstants.surfaceWhite,
      ),
    );
  }
}
