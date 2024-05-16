import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoritesScreenViewModel viewModel;

  const FavoritesScreen({super.key, required this.viewModel});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        bgColor: ColorConstants.surfacePrimaryDark,
        context: context,
        styles: styles,
        title: l10n?.favorites_title ?? '',
      ),
      body: _successBody(),
    );
  }

  Widget _successBody() {
    return Container(
      color: ColorConstants.surfacePrimaryDark,
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(children: buttons()),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8);
              },
              itemCount: 5,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return listViewCell('Engine', index);
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buttons() {
    return [0, 1, 2].map((button) {
      return Row(
        children: [
          customTabButton('Units'),
          const SizedBox(
            width: 8,
          ),
        ],
      );
    }).toList();
  }

  Widget listViewCell(String title, int index) {
    final styles = Theme.of(context).textTheme;

    return InkWell(
      // onTap: () {
      //   Navigator.pushNamed(
      //     context,
      //     'asdsada',
      //     arguments: index,
      //   );
      // },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorConstants.surfaceSecondary,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12, top: 12, bottom: 12),
          child: Row(
            children: [
              Expanded(child: Text(title, style: styles.titleMedium?.copyWith(color: ColorConstants.onSurfaceWhite))),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.17, vertical: 4.5),
                child: Icon(Icons.bookmark, size: 20, color: ColorConstants.surfaceWhite),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customTabButton(String title) {
    return CustomButton(
      height: 28,
      textColor: ColorConstants.onSurfaceWhite,
      borderColor: ColorConstants.stroke,
      borderRadius: 8,
      title: CustomButtonTitle(
        text: title,
      ),
      state: CustomButtonStates.outlined,
      onPressed: () => (),
    );
  }

  Widget placeholder() {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 65, right: 65),
      color: ColorConstants.surfacePrimaryDark,
      child: Center(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                R.ASSETS_BOOKMARK_SVG,
                height: 128,
                width: 128,
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                l10n?.favorites_placeholder_title ?? '',
                textAlign: TextAlign.center,
                style: styles.titleMedium
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                l10n?.favorites_placeholder_description ?? '',
                style: styles.bodyMedium
                    ?.copyWith(color: ColorConstants.onSurfaceWhite80),
              )
            ],
          ),
        ),
      ),
    );
  }
}
