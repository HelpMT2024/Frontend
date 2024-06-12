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

  bool _passwordVisible = false;
  bool _newPasswordVisible = false;
  bool _newPasswordRepeatVisible = false;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        title: l10n?.reset_password ?? '',
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
              _body(context, styles, l10n),
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

  Widget _body(BuildContext context, TextTheme styles, AppLocalizations? l10n) {
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
                ..._fields(l10n),
                const SizedBox(height: 8),
                _submitButton(l10n, context),
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
        onSaved: widget.viewModel.savePassword,
        validator: widget.viewModel.validatePassword,
        title: l10n?.password ?? '',
        placeholder: l10n?.enter_password_prompt,
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
        onSaved: widget.viewModel.saveNewPassword,
        validator: widget.viewModel.validateNewPassword,
        title: l10n?.new_password ?? '',
        placeholder: l10n?.new_password_prompt ?? '',
        promptText: l10n?.password_prompt ?? '',
        obscureText: true,
        hideEye: false,
        passwordVisible: _newPasswordVisible,
        needShowPassword: () {
          setState(() {
            _newPasswordVisible = !_newPasswordVisible;
          });
        },
      ),
      const SizedBox(height: 6),
      AuthorizationField(
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.saveConfirmPassword,
        validator: (value) =>
            widget.viewModel.validateConfirmPassword(value, l10n),
        title: l10n?.confirm_password_prompt ?? '',
        placeholder: l10n?.confirm_password_prompt,
        obscureText: true,
        hideEye: false,
        passwordVisible: _newPasswordRepeatVisible,
        needShowPassword: () {
          setState(() {
            _newPasswordRepeatVisible = !_newPasswordRepeatVisible;
          });
        },
      ),
    ];
  }

  Widget _submitButton(AppLocalizations? l10n, BuildContext context) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.save_new_password_title ?? ''),
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
