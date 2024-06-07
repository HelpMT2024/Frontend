import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/profile_flow/language_screen/language_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/round_checkbox.dart';

enum AppLanguage {
  eng,
  esp,
}

class LanguageScreen extends StatefulWidget {
  final LanguageScreenViewModel viewModel;

  const LanguageScreen({super.key, required this.viewModel});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  AppLanguage choosenLanguage = AppLanguage.eng;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
        appBar: MainNavigationBar(
          title: l10n?.language,
          context: context,
          styles: styles,
          bgColor: ColorConstants.surfacePrimaryDark,
        ),
        backgroundColor: ColorConstants.surfacePrimaryDark,
        body: _body(styles));
  }

  Widget _body(TextTheme styles) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _content(styles),
        ),
      ),
    );
  }

  List<Widget> _content(TextTheme styles) {
    return [
      _checkboxItem(
        styles: styles,
        title: 'English',
        isChecked: choosenLanguage == AppLanguage.eng,
        onTap: (value) {
          setState(() {
            if (value) {
              choosenLanguage = AppLanguage.eng;
            }
          });
        },
      ),
      const SizedBox(height: 8),
      Stack(
        children: [
          _checkboxItem(
            styles: styles,
            title: 'Español',
            isChecked: choosenLanguage == AppLanguage.esp,
            onTap: (value) {
              setState(() {
                if (value) {
                  choosenLanguage = AppLanguage.esp;
                }
              });
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _comingSoon(styles),
          ),
        ],
      ),
    ];
  }

  Widget _checkboxItem({
    required TextTheme styles,
    required String title,
    required bool isChecked,
    required void Function(bool) onTap,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isChecked
              ? ColorConstants.onSurfacePrimaryLighter
              : ColorConstants.surfaceWhite.withAlpha(20),
          width: isChecked ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundCheckbox(isChecked: isChecked, onTap: onTap),
          const SizedBox(width: 8),
          Text(
            title,
            style: styles.bodyLarge?.copyWith(
              color: ColorConstants.surfaceWhite,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _comingSoon(TextTheme styles) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      decoration: BoxDecoration(
        color: ColorConstants.onSurfaceSecondary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        'COMING SOON',
        style: styles.bodySmall?.copyWith(
          color: ColorConstants.onSurfaceWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
