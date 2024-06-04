import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/problem_case.dart';
import 'package:help_my_truck/ui/faults_flow/problem_case_screen/problem_case_view_model.dart';
import 'package:help_my_truck/ui/widgets/button_group.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_navigation_bar_bottom.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/pdf_button.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';
import 'package:help_my_truck/ui/widgets/warning_lights_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProblemCaseScreen extends StatefulWidget {
  final ProblemCaseScreenViewModel viewModel;
  final FavoriteModelType itemType = FavoriteModelType.problemCase;

  const ProblemCaseScreen({super.key, required this.viewModel});

  @override
  State<ProblemCaseScreen> createState() => _ProblemCaseScreenState();
}

class _ProblemCaseScreenState extends State<ProblemCaseScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        bottom: _navBarTitle(styles),
        bgColor: ColorConstants.surfacePrimaryDark,
        action: [VehicleNavBarActions(
          integrationId: widget.viewModel.config.id,
          type: widget.itemType.filterKey(),
          provider: widget.viewModel.favoritesProvider,
        )],
        toolbarHeight: 52,
      ),
      body: Stack(
        children: [
          Container(color: ColorConstants.surfacePrimaryDark),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: StreamBuilder<ProblemCase>(
              stream: widget.viewModel.problem,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(child: _body());
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
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.viewModel.hasWarnings) ...{
          WarningLightsRow(warnings: widget.viewModel.warnings),
          const SizedBox(height: 24),
        },
        if (widget.viewModel.hasDescription) ...{
          _text(Theme.of(context).textTheme),
        },
        _instructionsButtons(),
        if (widget.viewModel.hasVideos) ...{
          HorizontalVideoContainer(videos: widget.viewModel.videos)
        }
      ],
    );
  }

  Widget _instructionsButtons() {
    final viewModel = widget.viewModel;
    final buttons = viewModel.pdfFiles.map((e) {
      return PDFButton(file: e);
    }).toList();

    return ButtonGroup(
      buttons: [...buttons, const CommentButton(disableFlex: true)],
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
        widget.viewModel.description,
      ).documentToWidgetTree,
    );
  }

  PreferredSize _navBarTitle(TextTheme styles) {
    return mainNavigationBarBottom(
      context: context,
      title: widget.viewModel.config.name,
    );
  }
}
