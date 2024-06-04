import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/unit.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/vehicle_navigation_helper.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/custom_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/unit_observer_screen/unit_observer_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';

class UnitObserverScreen extends StatefulWidget {
  final UnitObserverViewModel viewModel;
  final FavoriteModelType itemType = FavoriteModelType.unit;

  const UnitObserverScreen({super.key, required this.viewModel});

  @override
  State<UnitObserverScreen> createState() => _UnitObserverScreenState();
}

class _UnitObserverScreenState extends State<UnitObserverScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: widget.viewModel.config.name,
        action: [
          VehicleNavBarActions(
            integrationId: widget.viewModel.config.id,
            type: widget.itemType.filterKey(),
            provider: widget.viewModel.favoritesProvider, 
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedPage: NavBarPage.home,
        onItemTapped: (item) => VehicleNavigationHelper.navigateTo(
            NavBarPage.fromPage(item), context, false),
      ),
      body: Stack(
        children: [
          Container(decoration: appGradientBgDecoration),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
            child: StreamBuilder<Unit>(
              stream: widget.viewModel.unit,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _body(snapshot.data!);
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

  Widget _body(Unit data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _content(data) ?? const SizedBox(),
          if (widget.viewModel.hasProblems) ...{
            const SizedBox(height: 32),
            _problemsButtons(),
          },
          const SizedBox(height: 16),
          const CommentButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _problemsButtons() {
    return ProblemsButtons(problems: widget.viewModel.problems);
  }

  ReusableObserverWidget? _content(Unit data) {
    if (data.imageView == null) {
      return null;
    }

    final models = data.children
        .map((e) => ReusableModel(id: e.id, name: e.name, icon: e.image))
        .toList();

    final config = ReusableObserverWidgetConfig(
      imageView: data.imageView!,
      models: models,
      onModelSelected: (model) => widget.viewModel.onModelSelected(
        model.id,
        context,
      ),
    );

    return ReusableObserverWidget(config: config);
  }
}
