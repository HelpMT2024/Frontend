import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/ui/faults_flow/fault_screen/fault_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/button_group.dart';
import 'package:help_my_truck/ui/widgets/comment_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/main_navigation_bar_bottom.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/pdf_button.dart';
import 'package:help_my_truck/ui/widgets/vehicle_nav_bar_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/videos/horizontal_video_container.dart';
import 'package:help_my_truck/ui/widgets/web_view_screen.dart';

class FaultScreen extends StatefulWidget {
  final FaultScreenViewModel viewModel;

  const FaultScreen({super.key, required this.viewModel});

  @override
  State<FaultScreen> createState() => _FaultScreenState();
}

class _FaultScreenState extends State<FaultScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final backgroundColor = ColorConstants.surfacePrimaryDark;

    return StreamBuilder<ContentfulItem>(
      stream: widget.viewModel.itemStreamController.stream,
      builder: (context, AsyncSnapshot itemSnapshot) {
        return Stack(
          children: [
            Container(
              color: backgroundColor,
            ),
            StreamBuilder<Fault>(
              stream: widget.viewModel.fault,
              builder: (context, snapshot) {
                if (snapshot.data?.showAsPdf == true) {
                  return WebViewScreen(
                    pdfFile: snapshot.data!.pdfFilesCollection.items.first,
                  );
                }
                return Scaffold(
                  appBar: MainNavigationBar(
                    context: context,
                    styles: styles,
                    action: (snapshot.data?.showAsPdf ?? true)
                        ? []
                        : [
                            VehicleNavBarActions(
                              item: itemSnapshot.data,
                              provider: widget.viewModel.itemProvider,
                            ),
                          ],
                    bottom: _navBarTitle(styles, backgroundColor),
                    bgColor: backgroundColor,
                  ),
                  body: Stack(
                    children: [
                      Container(color: ColorConstants.surfacePrimaryDark),
                      if (snapshot.hasData) ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                          child: _body(snapshot.data!, itemSnapshot.data),
                        ),
                      } else ...{
                        Loadable(forceLoad: true, child: Container()),
                      },
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _body(Fault model, ContentfulItem? item) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (model.image != null) ...{
            Image.network(model.image!.url),
            const SizedBox(height: 24),
          },
          if (model.description != null) _description(styles, model),
          const SizedBox(height: 24),
          _buttons(model, l10n, item),
          HorizontalVideoContainer(videos: model.videosCollection.items),
        ],
      ),
    );
  }

  Widget _buttons(Fault fault, AppLocalizations? l10n, ContentfulItem? item) {
    final buttons = [
      ...fault.pdfFilesCollection.items.map((e) => PDFButton(file: e)),
      CommentButton(id: item?.id, disableFlex: true),
    ];

    return ButtonGroup(buttons: buttons);
  }

  Widget _description(TextTheme styles, Fault model) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 16,
              color: ColorConstants.onSurfaceWhite,
            ),
            const SizedBox(width: 4),
            Text(
              l10n?.fault_code_description_title ?? '',
              style: styles.titleMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DefaultTextStyle.merge(
          style: styles.labelLarge?.merge(
            TextStyle(
              color: ColorConstants.onSurfaceWhite.withAlpha(210),
            ),
          ),
          child: ContentfulRichText(model.description).documentToWidgetTree,
        ),
      ],
    );
  }

  PreferredSize _navBarTitle(TextTheme styles, Color backgroundColor) {
    return mainNavigationBarBottom(
        context: context,
        title: widget.viewModel.config.text,
        backgroundColor: backgroundColor);
  }
}
