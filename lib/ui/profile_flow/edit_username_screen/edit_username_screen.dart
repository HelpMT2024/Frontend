import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/profile_flow/edit_username_screen/edit_username_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/auth_field.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';

import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditUsernameScreen extends StatefulWidget {
  final EditUsernameScreenViewModel viewModel;
  final String username;
  final _controller = TextEditingController();

  EditUsernameScreen({
    super.key,
    required this.viewModel,
    required this.username,
  }) {
    _controller.text = username;
  }

  @override
  State<EditUsernameScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<EditUsernameScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        title: l10n?.edit_username_title ?? '',
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
                _textField(l10n),
                const SizedBox(height: 28),
                _submitButton(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(AppLocalizations? l10n) {
    return AuthorizationField(
      title: l10n?.username,
      autovalidate: AutovalidateMode.onUserInteraction,
      onSaved: widget.viewModel.saveUsername,
      validator: widget.viewModel.validateUsername,
      controller: widget._controller,
    );
  }

  Widget _submitButton(AppLocalizations? l10n) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.save ?? ''),
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

  Widget _resendCode(AppLocalizations? l10n, TextTheme styles) {
    return Container(
      height: 32,
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: l10n?.didnt_receive_code ?? '',
              style: styles.bodyMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite,
              ),
            ),
            const TextSpan(text: ' '),
            TextSpan(
                text: l10n?.resend ?? '',
                style: styles.bodyMedium?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = () {}),
          ],
        ),
      ),
    );
  }
}
