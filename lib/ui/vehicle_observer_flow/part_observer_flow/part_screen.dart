import 'package:chewie/chewie.dart';
import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/lib/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/lib/loadable.dart';
import 'package:help_my_truck/ui/lib/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/part_observer_flow/part_view_model.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';

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
      appBar: MainNavigationBar(context: context, styles: styles),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        decoration: appGradientBgDecoration,
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
    );
  }

  Widget _body(Part data) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(),
            _symptomsSection(styles),
            _title(l10n?.fault_code_title, styles),
            _faultCodeSection(styles),
            if(widget.viewModel.part.value.pdfFilesCollection.items.isNotEmpty) ...{
              _title(l10n?.instructions_title, styles),
              ..._instructionsSection(styles),
            },
            _commentButton(l10n, styles),
            if(widget.viewModel.part.value.videosCollection.items.isNotEmpty) ...{
              _title(l10n?.tips_and_hinst_video, styles),
              ..._videoWidget()
            }
          ],
        ),
      ),
    );
  }

  Widget _image() {
    final part = widget.viewModel.part.value;

    return Image.network(part.imageView.imageFront.url);
  }

  Widget _title(String? text, TextTheme styles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          text ?? '',
          textAlign: TextAlign.left,
          style: styles.titleMedium?.merge(
            TextStyle(color: ColorConstants.onSurfaceWhite)
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _button({
    required String title,
    required VoidCallback onPressed,
    required TextTheme styles,
    bool isOutlined = false,
    Widget? leading,
    Widget? trailing,
    Color? color
  }) {
    return CustomButton(
      title: CustomButtonTitle(
        text: null,
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(leading != null) ...{
              leading,
              const SizedBox(width: 6),
            },
            Text(
              title,
              style: styles.labelLarge?.merge(
                TextStyle(color: ColorConstants.onSurfaceWhite)
              ),
            ),
            if(trailing != null) ...{
              const SizedBox(width: 6),
              trailing
            }
          ],
        )
      ),
      mainColor: color ?? ColorConstants.onSurfaceSecondary,
      state: isOutlined ? CustomButtonStates.outlined : CustomButtonStates.filled,
      onPressed: onPressed
    );
  }

  Widget _symptomsSection(TextTheme styles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        ContentfulRichText(
          widget.viewModel.part.value.description,
        ).documentToWidgetTree,
        const SizedBox(height: 32),
        _button(
          leading: Icon(
            Icons.nearby_error,
            size: 20,
            color: ColorConstants.warningColor,
          ),
          styles: styles,
          title: '',
          onPressed: () {}
        )
    ]);
  }

  Widget _faultCodeSection(TextTheme styles) {
    final images = [
      Icons.square_rounded,
      Icons.square_rounded
    ];
    final codes = [
      'SPN 652, FMI 3, 4, 5, 6, 7',
      'SPN 2798, FMI 3, 4'
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 4,
          children: images.map((e) => Icon(e)).toList(),
        ),
        const SizedBox(height: 4),
        ...codes.map((e) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _button(
              leading: Icon(
                Icons.error,
                color: ColorConstants.statesError,
                size: 20,
              ),
              styles: styles,
              title: e,
              onPressed: () {}
            ),
          );
        })
      ],
    );
  }

  List<Widget> _instructionsSection(TextTheme styles) {
    final viewModel = widget.viewModel;
    return viewModel.part.value.pdfFilesCollection.items.map((e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: _button(
          trailing: SvgPicture.asset(
            R.ASSETS_PDF_FILE_SVG,
            height: 20,
            width: 20,
          ),
          styles: styles,
          title: e.title,
          onPressed: () => viewModel.openPdf(e)
        ),
      );
    }).toList();
  }

  Widget _commentButton(AppLocalizations? l10n, TextTheme styles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: _button(
        title: l10n?.comments_title ?? '',
        styles: styles,
        trailing: Icon(
          Icons.chat_bubble,
          size: 20,
          color: ColorConstants.onSurfaceWhite,
        ),
        isOutlined: true,
        onPressed: () {}
      ),
    );
  }

  List<Widget> _videoWidget() {
    return widget.viewModel.part.value.videosCollection.items.map((e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Chewie(
          controller: widget.viewModel.getChewieController(e)
        ),
      );
    }).toList();
  }
}
