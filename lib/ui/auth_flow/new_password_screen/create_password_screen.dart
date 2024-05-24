import 'package:flutter/material.dart';

import '../../../const/colors.dart';
import '../../widgets/auth_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/nav_bar/main_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'create_password_screen_view_model.dart';

class CreatePasswordScreen extends StatefulWidget {
  final CreatePasswordScreenViewModel viewModel;

  const CreatePasswordScreen({super.key, required this.viewModel});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

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
      body: _body(context, styles),
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
                  l10n?.new_password ?? '',
                  style: styles.headlineSmall?.copyWith(
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ..._fields(l10n),
                const SizedBox(height: 8),
                _submitButton(l10n),
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
        obscureText: true,
        passwordVisible: passwordVisible,
        hideEye: false,
        needShowPassword: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      ),
      AuthorizationField(
        autovalidate: AutovalidateMode.onUserInteraction,
        onSaved: widget.viewModel.savePassword,
        validator: widget.viewModel.validatePassword,
        title: l10n?.confirm_password ?? '',
        obscureText: true,
        passwordVisible: passwordVisible,
        hideEye: false,
        needShowPassword: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      ),
    ];
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
          widget.viewModel.submit();
        }
      },
    );
  }
}
