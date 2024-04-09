import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class MainNavigationBar extends AppBar {
  MainNavigationBar({
    super.key,
    required BuildContext context,
    required TextTheme styles,
    String? title,
    Color? bgColor,
    List<Widget>? action,
    bool hasLeading = true,
    super.bottom,
    VoidCallback? onTapBack,
  }) : super(
          shadowColor: bgColor ?? ColorConstants.appBarColor,
          elevation: 0,
          backgroundColor: bgColor ?? ColorConstants.appBarColor,
          titleSpacing:
              hasLeading && ModalRoute.of(context)?.isFirst == false ? 0 : 16,
          centerTitle: false,
          title: _title(title, styles),
          actions: action,
          leading: hasLeading
              ? _backButton(
                  styles,
                  context,
                  title,
                  onTapBack,
                )
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

  static IconButton? _backButton(
    TextTheme styles,
    BuildContext context,
    String? title,
    VoidCallback? onTapBack,
  ) {
    if (ModalRoute.of(context)?.isFirst == true) {
      return null;
    }

    return IconButton(
      icon: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: ColorConstants.onSurfaceWhite,
          ),
        ],
      ),
      onPressed: () {
        onTapBack != null ? onTapBack() : Navigator.of(context).pop();
      },
    );
  }
}
