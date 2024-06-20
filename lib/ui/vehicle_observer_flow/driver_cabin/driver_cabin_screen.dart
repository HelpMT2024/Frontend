import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/driver_cabin/driver_cabin_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/widgets/bottom_reusable_container.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';

class DriverCabinScreen extends StatefulWidget {
  final DriverCabinViewModel viewModel;

  const DriverCabinScreen({super.key, required this.viewModel});

  @override
  State<DriverCabinScreen> createState() => _DriverCabinScreenState();
}

class _DriverCabinScreenState extends State<DriverCabinScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return StreamBuilder<ContentfulItem>(
      stream: widget.viewModel.itemStreamController.stream,
      builder: (context, itemSnapshot) {
        return Scaffold(
          appBar: MainNavigationBar(
            context: context,
            styles: styles,
            title: widget.viewModel.config.name,
            action: [
              VehicleNavBarActions(
                item: itemSnapshot.data,
                provider: widget.viewModel.itemProvider,
              )
            ],
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
                      return _body(snapshot.data!, itemSnapshot.data);
                    } else {
                      return Loadable(forceLoad: true, child: Container());
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _body(System data, ContentfulItem? item) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_content(data) != null) _content(data)!,
          const SizedBox(height: 32),
          CommentButton(id: item?.id),
          HorizontalVideoContainer(videos: data.videos ?? []),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget? _content(System data) {
    if (data.imageView == null) {
      return null;
    }
    final vm = widget.viewModel;
    final models = [vm.searchComponent, vm.warningLightComponent]
        .where((e) => e != null)
        .map((e) => ReusableModel(id: e!.id, name: e.name, icon: e.image))
        .toList();
    models.firstOrNull?.color = ColorConstants.statesDanger;
    models.firstOrNull?.textColor = ColorConstants.onSurfaceHigh;

    final model = ReusableObserverWidgetConfig(
      imageView: data.imageView!,
      models: models,
      onModelSelected: (model) => vm.onModelSelected(model.id, context),
    );

    return ReusableObserverWidget(config: model);
  }
}
