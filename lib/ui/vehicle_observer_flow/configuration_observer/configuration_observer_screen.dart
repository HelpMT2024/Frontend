import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/configuration.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/configuration_observer/configuration_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';

class ConfigurationObserverScreen extends StatefulWidget {
  final ConfigurationObserverViewModel viewModel;
  final FavoriteModelType itemType = FavoriteModelType.configuration;

  const ConfigurationObserverScreen({super.key, required this.viewModel});

  @override
  State<ConfigurationObserverScreen> createState() =>
      _ConfigurationObserverScreenState();
}

class _ConfigurationObserverScreenState
    extends State<ConfigurationObserverScreen> {
  String get title =>
      '${widget.viewModel.config.truck.name} ${widget.viewModel.config.engine.name}'
          .toUpperCase();

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: title,
        action: const [VehicleNavBarActions(hideBookmark: true)],
      ),
      body: Stack(
        children: [
          Container(decoration: appGradientBgDecoration),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
            child: StreamBuilder<Configuration>(
              stream: widget.viewModel.configuration,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder(
                      future: widget.viewModel.itemProvider.processItem(
                        snapshot.data!.id,
                        widget.itemType.filterKey(),
                      ),
                      builder: (context, itemSnapshot) {
                        return _body(snapshot.data!, itemSnapshot.data);
                      });
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

  Widget _body(Configuration data, ContentfulItem? item) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _content(data),
          const SizedBox(height: 32),
          CommentButton(id: item?.id),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  ReusableObserverWidget _content(Configuration data) {
    final models = data.children
        .map((e) => ReusableModel(id: e.id, name: e.name, icon: e.image))
        .toList();

    final config = ReusableObserverWidgetConfig(
      imageView: data.imageView,
      models: models,
      onModelSelected: (model) => widget.viewModel.onModelSelected(
        model.id,
        context,
      ),
    );

    return ReusableObserverWidget(config: config);
  }
}
