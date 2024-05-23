import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';

import '../../../const/colors.dart';
import '../../widgets/auth_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/nav_bar/main_navigation_bar.dart';
import 'reset_password_screen_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordScreenViewModel viewModel;

  const ResetPasswordScreen({super.key, required this.viewModel});

  @override
  State<ResetPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _acceptTerms = false;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: StreamBuilder(
        stream: widget.viewModel.isLoading,
        builder: (context, snapshot) {
          return Stack(
            children: [
              _body(context, styles),
              if (snapshot.data ?? false)
                Loadable(
                  forceLoad: true,
                  child: Container(),
                )
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, TextTheme styles) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n?.reset_password ?? '',
                  style: styles.headlineSmall?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n?.recovery_code ?? '',
                  style: styles.bodyMedium?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
                const SizedBox(height: 24),
                _emailTextField(l10n),
                const SizedBox(height: 28),
                _submitButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField(AppLocalizations? l10n) {
    return AuthorizationField(
      autovalidate: AutovalidateMode.onUserInteraction,
      onSaved: widget.viewModel.saveEmail,
      validator: (value) => null,
      title: l10n?.email ?? '',
      placeholder: l10n?.email ?? '',
    );
  }

  Widget _submitButton(AppLocalizations? l10n) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.conti_nue ?? ''),
      state: CustomButtonStates.filled,
      mainColor: ColorConstants.surfaceWhite,
      textColor: ColorConstants.onSurfaceHigh,
      height: 40,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          _formKey.currentState?.save();
          widget.viewModel.submit(context);
        }
      },
    );
  }
}
