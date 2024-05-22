import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/services/router/auth_router.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/widgets/auth_field.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'login_screen_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final LoginScreenViewModel viewModel;

  const LoginScreen({super.key, required this.viewModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

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
                  l10n?.login ?? '',
                  style: styles.headlineSmall?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ..._fields(l10n),
                const SizedBox(height: 8),
                _forgotPassword(l10n, styles),
                const SizedBox(height: 22),
                _submitButton(l10n),
                const SizedBox(height: 24),
                _registerAccount(l10n, styles),
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
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.saveEmail,
        validator: widget.viewModel.validateEmail,
        title: l10n?.email ?? '',
      ),
      AuthorizationField(
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.savePassword,
        validator: widget.viewModel.validatePassword,
        title: l10n?.password ?? '',
        obscureText: true,
        passwordVisible: _passwordVisible,
        hideEye: false,
        needShowPassword: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    ];
  }

  Widget _forgotPassword(AppLocalizations? l10n, TextTheme styles) {
    return Text.rich(
      TextSpan(
          text: l10n?.forgot_password ?? '',
          style: styles.bodyMedium?.copyWith(
              color: ColorConstants.onSurfaceWhite,
              fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(AuthRouteKeys.resetPassword);
            }),
    );
  }

  Widget _submitButton(AppLocalizations? l10n) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.login ?? ''),
      state: CustomButtonStates.filled,
      mainColor: ColorConstants.surfaceWhite,
      textColor: ColorConstants.onSurfaceHigh,
      height: 40,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          _formKey.currentState?.save();
          widget.viewModel.submit(context, () {
            setState(() {});
          });
        }
      },
    );
  }

  Widget _registerAccount(AppLocalizations? l10n, TextTheme styles) {
    return Container(
      height: 32,
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: l10n?.account_not_exists ?? '',
              style: styles.bodyMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
                text: l10n?.sign_up ?? '',
                style: styles.bodyMedium?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed(AuthRouteKeys.authScreen);
                  }),
          ],
        ),
      ),
    );
  }
}
