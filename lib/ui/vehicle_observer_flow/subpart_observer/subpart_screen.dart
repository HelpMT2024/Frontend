import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/app_consts.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/subpart.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/subpart_observer/subpart_view_model.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/button_group.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/custom_floating_button.dart';
import 'package:help_my_truck/ui/widgets/fault_code_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_navigation_bar_bottom.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/pdf_button.dart';
import 'package:help_my_truck/ui/widgets/problems_buttons.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:help_my_truck/ui/widgets/vehicle_title.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';
import 'package:help_my_truck/ui/widgets/videos/verical_video_container.dart';
import 'package:help_my_truck/ui/widgets/warning_lights_row.dart';

class SubPartScreen extends StatefulWidget {
  final SubPartViewModel viewModel;
  final FavoriteModelType itemType = FavoriteModelType.subPart;

  const SubPartScreen({super.key, required this.viewModel});

  @override
  State<SubPartScreen> createState() => _SubPartScreenState();
}

class _SubPartScreenState extends State<SubPartScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final backgroundColor = ColorConstants.surfacePrimary;

    return FutureBuilder(
      future: widget.viewModel.itemProvider.processItem(
        widget.viewModel.config.id,
        widget.itemType.filterKey(),
      ),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: MainNavigationBar(
            context: context,
            styles: styles,
            action: [
              VehicleNavBarActions(
                item: snapshot.data,
                provider: widget.viewModel.itemProvider,
              )
            ],
            bottom: _navBarTitle(styles, backgroundColor),
            toolbarHeight: 52,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: CustomFloatingButton(
            onPressed: () => widget.viewModel.onSearch(context),
          ),
          body: Stack(
            children: [
              Container(decoration: appGradientBgDecoration),
              StreamBuilder<SubPart>(
                stream: widget.viewModel.part,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _body(snapshot.data!);
                  } else {
                    return Loadable(forceLoad: true, child: Container());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSize _navBarTitle(TextTheme styles, Color backgroundColor) {
    return mainNavigationBarBottom(
      context: context,
      title: widget.viewModel.config.name,
      backgroundColor: backgroundColor,
    );
  }

  Widget _body(SubPart data) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: AppConsts.componentObserverPadding(
          isNeedTop: widget.viewModel.hasImage,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.viewModel.hasImage) ...{
              _image(),
            } else ...{
              _verticalVideoWidget(),
            },
            if (widget.viewModel.hasDescription) ...{
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: _symptomsSection(styles),
              ),
            },
            if (widget.viewModel.hasProblems) ...{
              SizedBox(height: widget.viewModel.hasDescription ? 8 : 32),
              _problemsButtons(styles),
            },
            if (widget.viewModel.hasFaults || widget.viewModel.hasWarnings) ...{
              const SizedBox(height: 4),
              if (widget.viewModel.hasFaults)
                _title(l10n?.favorites_item_type_fault_codes, styles),
              _warningIcons(),
              _faultCodeSection(),
            },
            if (widget.viewModel.hasPDF) ...{
              const SizedBox(height: 8),
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
    if (part?.imageView == null && part?.imageView?.imageFront == null) {
      return const SizedBox();
    }
    return Image.network(part!.imageView!.imageFront!.url);
  }

  Widget _title(String? text, TextTheme styles) {
    return VehicleTitle(text: text);
  }

  Widget _warningIcons() {
    if (!widget.viewModel.hasWarnings) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: WarningLightsRow(warnings: widget.viewModel.warnings),
    );
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
        const SizedBox(height: 8),
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
