import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen/profile_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileScreenViewModel viewModel;

  const ProfileScreen({super.key, required this.viewModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
        appBar: MainNavigationBar(
          context: context,
          styles: styles,
          bgColor: ColorConstants.surfacePrimaryDark,
          action: [_settings()],
        ),
        backgroundColor: ColorConstants.surfacePrimaryDark,
        body: StreamBuilder(
            stream: widget.viewModel.info,
            builder: (context, snapshot) {
              return _body(styles, l10n, widget.viewModel.userInfo);
            }));
  }

  Widget _body(TextTheme styles, AppLocalizations? l10n, UserInfo? data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data?.username ?? '',
                style: styles.titleLarge
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              _edit(l10n, styles),
            ],
          ),
          Text(
            data?.email ?? '',
            style: styles.bodyMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
          const SizedBox(height: 24),
          Text(
            l10n?.your_trucks ?? '',
            style: styles.titleMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: widget.viewModel.trucks
                  .asMap()
                  .entries
                  .map((e) => _truckItem(e.key, e.value, l10n, styles))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _truckItem(
      int index, Truck truck, AppLocalizations? l10n, TextTheme styles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        height: 118,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: ColorConstants.surfaceSecondary,
        ),
        child: Row(
          children: [
            Image.network(truck.image.url),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truck.name,
                    style: styles.labelLarge
                        ?.copyWith(color: ColorConstants.onSurfaceWhite),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            R.ASSETS_ENGINE_ICON_SVG,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n?.engine ?? '',
                            style: styles.bodySmall?.copyWith(
                              color: ColorConstants.onSurfaceWhite,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.viewModel.engines[index].name,
                        style: styles.labelMedium?.copyWith(
                          color: ColorConstants.onSurfaceWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settings() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        icon: Icon(
          Icons.settings,
          color: ColorConstants.onSurfaceWhite,
          size: 24,
        ),
        onPressed: () => widget.viewModel.settings(context),
      ),
    );
  }

  Widget _edit(AppLocalizations? l10n, TextTheme styles) {
    return InkWell(
      onTap: () {
        widget.viewModel.editUsername(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit,
            size: 20,
            color: ColorConstants.onSurfaceWhite,
          ),
          const SizedBox(width: 6),
          Text(
            l10n?.edit ?? '',
            style: styles.bodyMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
        ],
      ),
    );
  }
}
