import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/fault_code_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/component_observer/component_observer_view_model.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';
import 'package:help_my_truck/ui/widgets/videos/verical_video_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/warning_lights_row.dart';

class ComponentObserverScreen extends StatefulWidget {
  final ComponentObserverViewModel viewModel;

  const ComponentObserverScreen({super.key, required this.viewModel});

  @override
  State<ComponentObserverScreen> createState() =>
      _ComponentObserverScreenState();
}

class _ComponentObserverScreenState extends State<ComponentObserverScreen> {
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
            padding: EdgeInsets.fromLTRB(
              16,
              widget.viewModel.hasImage ? 24 : 0,
              16,
              24,
            ),
            child: StreamBuilder<Component>(
              stream: widget.viewModel.component,
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

  Widget _body(Component data) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.viewModel.hasImage) ...{
            const SizedBox(height: 24),
            _content(data)!,
          } else ...{
            VerticalVideoContainer(videos: widget.viewModel.videos),
          },
          if (widget.viewModel.hasProblems) ...{
            const SizedBox(height: 24),
            _problemsButtons()
          },
          if (widget.viewModel.hasFaults || widget.viewModel.hasWarnings) ...{
            const SizedBox(height: 12),
            VehicleTitle(text: l10n?.fault_code_title),
            _warningIcons(),
            faults(),
          },
          const SizedBox(height: 24),
          const CommentButton(),
          if (widget.viewModel.hasImage) ...{
            HorizontalVideoContainer(videos: widget.viewModel.videos),
          },
        ],
      ),
    );
  }

  Widget _problemsButtons() {
    return ProblemsButtons(problems: widget.viewModel.problems);
  }

  Widget _warningIcons() {
    if (!widget.viewModel.hasWarnings) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: WarningLightsRow(warnings: widget.viewModel.warnings),
    );
  }

  Widget faults() {
    return Column(
      children: widget.viewModel.faults
          .map((e) => FaultCodeButton(fault: e))
          .toList(),
    );
  }

  ReusableObserverWidget? _content(Component data) {
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