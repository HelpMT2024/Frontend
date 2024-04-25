import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/fault.dart';
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

    return Stack(
      children: [
        Container(
          color: ColorConstants.surfacePrimaryDark,
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
                action: const [VehicleNavBarActions()],
                bottom: _navBarTitle(styles),
                bgColor: ColorConstants.surfacePrimaryDark,
              ),
              body: Stack(
                children: [
                  Container(color: ColorConstants.surfacePrimaryDark),
                  if (snapshot.hasData) ...{
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: _body(snapshot.data!),
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
  }

  Widget _body(Fault model) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (model.image != null) Image.network(model.image!.url),
          const SizedBox(height: 24),
          _description(styles, model),
          const SizedBox(height: 24),
          _buttons(model, l10n),
          const SizedBox(height: 16),
          HorizontalVideoContainer(videos: model.videosCollection.items),
        ],
      ),
    );
  }

  Widget _buttons(Fault fault, AppLocalizations? l10n) {
    final buttons = [
      ...fault.pdfFilesCollection.items.map((e) => PDFButton(file: e)),
      const CommentButton(disableFlex: true),
    ];

    return ButtonGroup(buttons: buttons);
  }

  Widget _description(TextTheme styles, Fault model) {
    return DefaultTextStyle.merge(
      style: styles.labelLarge?.merge(
        TextStyle(
          color: ColorConstants.onSurfaceWhite.withAlpha(210),
        ),
      ),
      child: ContentfulRichText(model.description).documentToWidgetTree,
    );
  }

  PreferredSize _navBarTitle(TextTheme styles) {
    return mainNavigationBarBottom(
      context: context,
      title: widget.viewModel.config.text,
    );
  }
}
