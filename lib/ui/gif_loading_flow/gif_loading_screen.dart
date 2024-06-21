import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/ui/gif_loading_flow/gif_loading_screen_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GifLoadingScreen extends StatefulWidget {
  final GifLoadingScreenViewModel viewModel;

  const GifLoadingScreen({super.key, required this.viewModel});

  @override
  State<GifLoadingScreen> createState() => _GifLoadingScreenState();
}

class _GifLoadingScreenState extends State<GifLoadingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.surfacePrimary,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: ColorConstants.surfacePrimary,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _background(context),
            _progressIndicator(context),
          ],
        ),
      ),
    );
  }

  SizedBox _background(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        R.ASSETS_SPLASH_SCREEN_PNG,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding _progressIndicator(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              l10n?.loading_assets ?? '',
              style: styles.labelLarge?.copyWith(
                color: ColorConstants.onSurfaceWhite64,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<double>(
              stream: widget.viewModel.progress,
              builder: (context, snapshot) {
                return LinearProgressIndicator(
                  color: ColorConstants.surfacePrimary,
                  value: snapshot.data ?? 0.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
