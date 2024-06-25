import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class MainNavigationBar extends AppBar {
  MainNavigationBar({
    super.key,
    required BuildContext context,
    required TextTheme styles,
    String? title,
    String? bottomTitle,
    Color? bgColor,
    List<Widget>? action,
    bool hasLeading = true,
    double toolbarHeight = 48,
    super.bottom,
    VoidCallback? onTapBack,
  }) : super(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: bgColor ?? ColorConstants.appBarColor,
          titleSpacing:
              hasLeading && ModalRoute.of(context)?.isFirst == false ? 0 : 16,
          centerTitle: false,
          title: _title(title, styles),
          actions: action,
          leadingWidth: 42,
          toolbarHeight: toolbarHeight,
          leading: hasLeading
              ? _backButton(styles, context, bottomTitle, onTapBack)
              : null,
          automaticallyImplyLeading: hasLeading,
        );

  static Widget _title(String? title, TextTheme styles) {
    return Text(
      title ?? '',
      style: styles.titleLarge?.merge(
        TextStyle(
          color: ColorConstants.surfaceWhite,
        ),
      ),
    );
  }

  static Widget? _backButton(
    TextTheme styles,
    BuildContext context,
    String? bottomTitle,
    VoidCallback? onTapBack,
  ) {
    if (ModalRoute.of(context)?.isFirst == true) {
      return null;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Row(
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
                color: ColorConstants.onSurfaceWhite,
              ),
            ],
          ),
          onPressed: () {
            onTapBack != null ? onTapBack() : Navigator.of(context).pop();
          },
        ),
        if (bottomTitle != null) ...{
          const SizedBox(height: 4),
          Text(
            bottomTitle,
            style: styles.titleLarge
                ?.merge(TextStyle(color: ColorConstants.onSurfaceWhite)),
          )
        }
      ],
    );
  }
}
