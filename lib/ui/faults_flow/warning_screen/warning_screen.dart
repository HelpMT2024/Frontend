import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/warning.dart';
import 'package:help_my_truck/ui/faults_flow/warning_screen/warning_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/warning_light_cell.dart';

import '../../widgets/main_bottom_bar.dart';
import '../../widgets/nav_bar/nav_bar_page.dart';

class WarningScreen extends StatefulWidget {
  final WarningScreenViewModel viewModel;
  final FavoriteModelSubType itemType = FavoriteModelSubType.warningLights;

  const WarningScreen({super.key, required this.viewModel});

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: l10n?.warning_page_title,
        action: [
          VehicleNavBarActions(
            integrationId: widget.viewModel.config.id,
            type: widget.itemType.filterKey(),
            provider: widget.viewModel.favoritesProvider,
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(
        selectedPage: NavBarPage.search,
        onItemTapped: (_) => widget.viewModel.onSearch(context),
        hideAllExceptSearch: true,
      ),
      body: Stack(
        children: [
          Container(decoration: appGradientBgDecoration),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: StreamBuilder<List<Warning>>(
              stream: widget.viewModel.warnings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _body();
                } else {
                  return Loadable(forceLoad: true, child: Container());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _lights(),
          const SizedBox(height: 32),
          const CommentButton(),
        ],
      ),
    );
  }

  Widget _lights() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        ...widget.viewModel.warnings.valueOrNull?.map((e) {
              return _warning(e);
            }) ??
            [],
      ],
    );
  }

  Widget _warning(Warning e) {
    final warning = ChildWarningLight(name: e.name, icon: e.icon);
    return GestureDetector(
      onTap: () => widget.viewModel.onModelSelected(e, context),
      child: SizedBox(
        height: 70,
        child: WarningLightCell(warning: warning),
      ),
    );
  }
}
