import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/system_observer_screen/system_observer_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/warning_button.dart';

class SystemObserverScreen extends StatefulWidget {
  final SystemObserverViewModel viewModel;

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
        action: const [VehicleNavBarActions()],
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
          const SizedBox(height: 32),
          const WarningButton(),
          const SizedBox(height: 16),
          const CommentButton(),
        ],
      ),
    );
  }

  ReusableObserverWidget? _content(System data) {
    if (data.imageView == null) {
      return null;
    }
    final models = data.children
        .map((e) => ReusableModel(id: e.id, name: e.name))
        .toList();

    final config = ReusableObserverWidgetConfig(
      imageView: data.imageView!,
      buttons: data.children.map((e) => e.image).toList(),
      models: models,
      onModelSelected: (model) => widget.viewModel.onModelSelected(
        model.id,
        context,
      ),
    );

    return ReusableObserverWidget(config: config);
  }
}
