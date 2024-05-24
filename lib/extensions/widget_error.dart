import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../const/colors.dart';
import '../services/router/auth_router.dart';
import '../services/shared_preferences_wrapper.dart';
import '../ui/widgets/custom_button.dart';

class ErrorValue {
  String? message;
  int? code;
  ErrorValue({required this.message, required this.code});
  ErrorValue.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }
}

Future<void> _handleError(ErrorValue? error, BuildContext context,
    {String? text}) {
  if (error?.code == 423) {
    return showDialog(
      context: context,
      builder: (context) => _error(
        error,
        context,
        () {
          SharedPreferencesWrapper.setToken(null);
          SharedPreferencesWrapper.setFCM('');
          Navigator.of(context).pushReplacementNamed(AuthRouteKeys.authScreen);
        },
        errorText: AppLocalizations.of(context)?.deleted_by_admin_error,
      ),
    );
  } else if (error?.message?.contains('Network is unreachable') == true ||
      error?.message?.contains('Failed host lookup') == true) {
    return showDialog(
      context: context,
      builder: (context) => _error(error, context, () => Navigator.pop(context),
          errorText: AppLocalizations.of(context)?.no_internet_connection),
    );
  }
  return showDialog(
    context: context,
    builder: (context) =>
        _error(error, context, () => Navigator.pop(context), errorText: text),
  );
}

Widget _error(
  ErrorValue? error,
  BuildContext context,
  Function() onPressed, {
  String? errorText,
}) {
  final styles = Theme.of(context).textTheme;

  return Center(
      child: AlertDialog(
    backgroundColor: ColorConstants.onSurfaceMedium,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    actionsPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
    title: Text(errorText ?? error?.message ?? '',
        textAlign: TextAlign.center,
        style: styles.bodyMedium
            ?.merge(const TextStyle(fontWeight: FontWeight.w700))),
    actions: <Widget>[
      CustomButton(
        title: CustomButtonTitle(text: 'OK'),
        state: CustomButtonStates.filled,
        onPressed: onPressed,
      )
    ],
  ));
}

extension WidgetErrorHandable on Widget {
  Widget error(ErrorValue? error, BuildContext context, Function() onPressed,
      {String? errorText}) {
    return _error(error, context, onPressed, errorText: errorText);
  }

  void handleError(ErrorValue? error, BuildContext context,
      {String? errorText}) {
    _handleError(error, context, text: errorText);
  }
}

extension StateErrorHandable on State {
  Widget error(ErrorValue? error, BuildContext context, Function() onPressed,
      {String? errorText}) {
    return _error(error, context, onPressed, errorText: errorText);
  }

  Future<Object?> handleError(ErrorValue? error, BuildContext context,
      {String? errorText}) {
    return _handleError(error, context, text: errorText);
  }
}

mixin ViewModelErrorHandable {
  void showAlertDialog(BuildContext context, String error) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text(l10n?.error ?? ''),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
