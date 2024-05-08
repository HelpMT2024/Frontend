import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/button_group.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/fault_code_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_navigation_bar_bottom.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_view_model.dart';
import 'package:help_my_truck/ui/widgets/pdf_button.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';
import 'package:help_my_truck/ui/widgets/videos/verical_video_container.dart';
import 'package:help_my_truck/ui/widgets/warning_lights_row.dart';

class PartScreen extends StatefulWidget {
  final PartViewModel viewModel;

  const PartScreen({super.key, required this.viewModel});

  @override
  State<PartScreen> createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        action: const [VehicleNavBarActions()],
        bottom: _navBarTitle(styles),
      ),
      body: Stack(
        children: [
          Container(decoration: appGradientBgDecoration),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
            child: StreamBuilder<Part>(
              stream: widget.viewModel.part,
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

  PreferredSize _navBarTitle(TextTheme styles) {
    return mainNavigationBarBottom(
      context: context,
      title: widget.viewModel.config.name,
    );
  }

  Widget _body(Part data) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          widget.viewModel.hasImage ? 24 : 0,
          16,
          16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.viewModel.hasImage) ...{
              _image(),
              _symptomsSection(styles),
            } else ...{
              _verticalVideoWidget(),
            },
            if (widget.viewModel.hasProblems) ...{
              const SizedBox(height: 32),
              _problemsButtons(styles),
            },
            if (widget.viewModel.hasFaults || widget.viewModel.hasWarnings) ...{
              _title(l10n?.fault_code_title, styles),
              _warningIcons(),
              _faultCodeSection(),
            },
            if (widget.viewModel.hasPDF) ...{
              _title(l10n?.instructions_title, styles),
            },
            _instructionsButtons(styles),
            if (widget.viewModel.hasVideos && widget.viewModel.hasImage)
              _horizontalVideoWidget()
          ],
        ),
      ),
    );
  }

  Widget _image() {
    final part = widget.viewModel.part.valueOrNull;
    if (part?.imageView == null) {
      return const SizedBox();
    }
    return Image.network(part!.imageView!.imageFront.url);
  }

  Widget _title(String? text, TextTheme styles) {
    return VehicleTitle(text: text);
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

  Widget _symptomsSection(TextTheme styles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        _text(styles),
      ],
    );
  }

  Widget _problemsButtons(TextTheme styles) {
    return ProblemsButtons(problems: widget.viewModel.problems);
  }

  Widget _text(TextTheme styles) {
    return DefaultTextStyle.merge(
      style: styles.labelLarge?.merge(
        TextStyle(
          color: ColorConstants.onSurfaceWhite.withAlpha(210),
        ),
      ),
      child: ContentfulRichText(
        widget.viewModel.part.valueOrNull?.description,
      ).documentToWidgetTree,
    );
  }

  Widget _faultCodeSection() {
    final codes = widget.viewModel.faults;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...codes.map(
          (e) {
            return FaultCodeButton(fault: e);
          },
        )
      ],
    );
  }

  Widget _instructionsButtons(TextTheme styles) {
    final viewModel = widget.viewModel;
    final buttons = viewModel.pdfFiles.map((e) {
      return PDFButton(file: e);
    }).toList();

    return ButtonGroup(
      buttons: [
        ...buttons,
        const SizedBox(height: 24),
        const CommentButton(disableFlex: true)
      ],
    );
  }

  Widget _verticalVideoWidget() {
    final videos = widget.viewModel.videos;

    return VerticalVideoContainer(videos: videos);
  }

  Widget _horizontalVideoWidget() {
    final videos = widget.viewModel.videos;

    return HorizontalVideoContainer(videos: videos);
  }
}
