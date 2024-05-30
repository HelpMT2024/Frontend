import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_selector_flow/truck_selector/truck_selector_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';

class TruckSelectorScreen extends StatefulWidget {
  final TruckSelectorViewModel viewModel;

  const TruckSelectorScreen({super.key, required this.viewModel});

  @override
  State<TruckSelectorScreen> createState() => _TruckSelectorScreenState();
}

class _TruckSelectorScreenState extends State<TruckSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(context: context, styles: styles),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        decoration: appGradientBgDecoration,
        child: StreamBuilder<List<Truck>>(
          stream: widget.viewModel.trucks,
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

  Widget _body(List<Truck> data) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _header(styles),
        const SizedBox(
          height: 80,
        ),
        if (data.isNotEmpty) _carousel(data),
        _indicator(data),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: CustomButton(
            title: CustomButtonTitle(text: l10n?.next ?? ''),
            state: CustomButtonStates.filled,
            mainColor: ColorConstants.surfaceWhite,
            textColor: ColorConstants.onSurfaceHigh,
            height: 48,
            onPressed: () => widget.viewModel.selectTruck(context),
          ),
        ),
      ],
    );
  }

  PageViewDotIndicator _indicator(List<Truck> data) {
    return PageViewDotIndicator(
      currentItem: widget.viewModel.currentTruckIndex,
      count: data.length,
      size: const Size(8, 8),
      unselectedColor: ColorConstants.surfaceWhite.withOpacity(0.5),
      selectedColor: ColorConstants.surfaceWhite,
    );
  }

  Widget _carousel(List<Truck> data) {
    final styles = Theme.of(context).textTheme;

    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) {
        final truck = data[index];
        return GestureDetector(
          onTap: () => widget.viewModel.selectTruck(context),
          child: Column(
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
          ),
        );
      },
      options: CarouselOptions(
        height: 336,
        onPageChanged: (index, reason) {
          setState(() {
            widget.viewModel.currentTruckIndex = index;
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
    return _proxySetter(
      Text(
        l10n!.choose_your_truck,
        style: styles.headlineSmall?.copyWith(
          color: ColorConstants.surfaceWhite,
        ),
      ),
    );
  }

  Widget _proxySetter(Widget child) {
    return GestureDetector(
      onTap: () => widget.viewModel.setProxy(context),
      child: child,
    );
  }
}
