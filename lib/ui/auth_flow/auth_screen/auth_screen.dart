import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/ui/auth_flow/auth_screen/auth_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';

import '../../widgets/auth_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/nav_bar/main_navigation_bar.dart';

class AuthScreen extends StatefulWidget {
  final AuthScreenViewModel viewModel;

  const AuthScreen({super.key, required this.viewModel});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordRepeatVisible = false;
  bool _passwordVisible = false;
  bool _emailAutoCheck = false;
  bool _acceptTerms = false;

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
                  l10n?.sign_up ?? '',
                  style: styles.headlineSmall?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ..._fields(l10n),
                const SizedBox(height: 8),
                _termsBlock(l10n, styles),
                const SizedBox(height: 12),
                _submitButton(l10n, context),
                const SizedBox(height: 24),
                _accountExists(l10n, styles),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _fields(AppLocalizations? l10n) {
    return [
      AuthorizationField(
        autovalidate: AutovalidateMode.disabled,
        onSaved: widget.viewModel.saveUsername,
        validator: (value) => null,
        title: l10n?.username ?? '',
      ),
      AuthorizationField(
        autovalidate: _emailAutoCheck
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        onSaved: widget.viewModel.saveEmail,
        validator: (value) => widget.viewModel.validateEmail(value),
        title: l10n?.email ?? '',
      ),
      AuthorizationField(
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.savePassword,
        validator: widget.viewModel.validatePassword,
        title: l10n?.password ?? '',
        promptText: l10n?.password_prompt ?? '',
        obscureText: true,
        hideEye: false,
        passwordVisible: _passwordVisible,
        needShowPassword: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
      const SizedBox(height: 6),
      AuthorizationField(
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.saveConfirmPassword,
        validator: (value) {
          return widget.viewModel.validateConfirmPassword(value, l10n);
        },
        title: l10n?.confirm_password ?? '',
        obscureText: true,
        hideEye: false,
        passwordVisible: _passwordRepeatVisible,
        needShowPassword: () {
          setState(() {
            _passwordRepeatVisible = !_passwordRepeatVisible;
          });
        },
      ),
    ];
  }

  Widget _termsBlock(AppLocalizations? l10n, TextTheme styles) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _acceptTerms,
          activeColor: ColorConstants.onSurfaceWhite,
          checkColor: ColorConstants.surfacePrimaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(width: 5.0, color: Colors.red),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _acceptTerms = value == true;
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.notice ?? '',
              style: styles.bodySmall
                  ?.copyWith(color: ColorConstants.onSurfaceWhite),
            ),
            _termsAndPrivacy(l10n, styles),
          ],
        ),
      ],
    );
  }

  Widget _termsAndPrivacy(AppLocalizations? l10n, TextTheme styles) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: l10n?.terms_button_title ?? '',
              style: styles.bodySmall?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(AuthRouteKeys.termsOfService);
                }),
          TextSpan(
            text: l10n?.and,
            style: styles.bodySmall
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
          ),
          TextSpan(
              text: l10n?.privacy_policy ?? '',
              style: styles.bodySmall?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(AuthRouteKeys.privacyPolicy);
                }),
        ],
      ),
    );
  }

  Widget _submitButton(AppLocalizations? l10n, BuildContext context) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.create_account_button_title ?? ''),
      state: CustomButtonStates.filled,
      mainColor: ColorConstants.surfaceWhite,
      textColor: ColorConstants.onSurfaceHigh,
      height: 40,
      onPressed: () {
        if ((_formKey.currentState?.validate() ?? false) && _acceptTerms) {
          _formKey.currentState?.save();
          _emailAutoCheck = true;
          widget.viewModel.submit(context, () {
            setState(() {});
          });
        }
      },
    );
  }

  Widget _accountExists(AppLocalizations? l10n, TextTheme styles) {
    return Container(
      height: 32,
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: l10n?.account_exists ?? '',
              style: styles.bodyMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
                text: l10n?.login ?? '',
                style: styles.bodyMedium?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    widget.viewModel.loginScreen(context);
                  }),
          ],
        ),
      ),
    );
  }
}
