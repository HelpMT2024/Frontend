import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/button_group.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/custom_floating_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/system_observer_screen/system_observer_view_model.dart';
import 'package:help_my_truck/ui/widgets/pdf_button.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';

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
        action: [
          VehicleNavBarActions(
            integrationId: widget.viewModel.config.id,
            type: widget.itemType.filterKey(),
            provider: widget.viewModel.favoritesProvider,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: CustomFloatingButton(
        onPressed: () => widget.viewModel.onSearch(context),
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
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_content(data) != null) _content(data)!,
          if (widget.viewModel.hasDescription) _symptomsSection(styles),
          if (widget.viewModel.hasProblems) ...{
            if (widget.viewModel.hasDescription) ...{
              const SizedBox(height: 16)
            } else ...{
              const SizedBox(height: 32),
            },
            _problemsButtons(),
          },
          if (widget.viewModel.hasPDF) ...{
            if (widget.viewModel.hasProblems) const SizedBox(height: 4),
            if (!widget.viewModel.hasProblems) const SizedBox(height: 16),
            _title(l10n?.instructions_title, styles),
          },
          _instructionsButtons(styles),
          const SizedBox(height: 8),
          if (data.children.isEmpty &&
              data.pdfFilesCollection.items.isEmpty &&
              data.problems.isEmpty)
            const SizedBox(height: 16),
          const CommentButton(),
          if (widget.viewModel.hasVideos) _horizontalVideoWidget(),
          const SizedBox(height: 24),
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

  Widget _symptomsSection(TextTheme styles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        _text(styles),
      ],
    );
  }

  Widget _text(TextTheme styles) {
    return DefaultTextStyle.merge(
      style: styles.labelLarge?.merge(
        TextStyle(
          color: ColorConstants.onSurfaceWhite.withAlpha(210),
        ),
      ),
      child: ContentfulRichText(
        widget.viewModel.system.valueOrNull?.description,
      ).documentToWidgetTree,
    );
  }

  Widget _instructionsButtons(TextTheme styles) {
    final viewModel = widget.viewModel;
    final buttons = viewModel.pdfFiles.map((e) {
      return PDFButton(file: e);
    }).toList();

    return ButtonGroup(buttons: [...buttons]);
  }

  Widget _title(String? text, TextTheme styles) {
    return VehicleTitle(text: text);
  }

  Widget _horizontalVideoWidget() {
    final videos = widget.viewModel.videos;

    return HorizontalVideoContainer(videos: videos);
  }
}
