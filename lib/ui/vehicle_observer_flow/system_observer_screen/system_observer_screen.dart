import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/system_observer_screen/system_observer_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';

class SystemObserverScreen extends StatefulWidget {
  final SystemObserverViewModel viewModel;
  final FavoriteModelType itemType = FavoriteModelType.system;

  const SystemObserverScreen({super.key, required this.viewModel});

  @override
  State<SystemObserverScreen> createState() => _SystemObserverScreenState();
}

class _SystemObserverScreenState extends State<SystemObserverScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: widget.viewModel.config.name,
        action: [VehicleNavBarActions(
          integrationId: widget.viewModel.config.id,
          type: widget.itemType.filterKey(),
          provider: widget.viewModel.favoritesProvider,
        )],
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
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
            child: StreamBuilder<System>(
              stream: widget.viewModel.system,
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

  Widget _body(System data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_content(data) != null) _content(data)!,
          if (widget.viewModel.hasProblems) ...{
            const SizedBox(height: 32),
            _problemsButtons(),
          },
          const SizedBox(height: 16),
          const CommentButton(),
        ],
      ),
    );
  }

  Widget _problemsButtons() {
    return ProblemsButtons(problems: widget.viewModel.problems);
  }

  ReusableObserverWidget? _content(System data) {
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
