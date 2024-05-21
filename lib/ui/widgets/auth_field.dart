import 'package:help_my_truck/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AuthorizationField extends FormField<String> {
  final String? placeholder;
  final String? title;
  final String? promptText;
  final bool obscureText;
  final bool passwordVisible;
  final bool hideEye;
  final void Function()? needShowPassword;
  final TextEditingController? controller;

  AuthorizationField(
      {Key? key,
      required FormFieldSetter<String> onSaved,
      required FormFieldValidator<String> validator,
      this.needShowPassword,
      String? restorationId,
      this.controller,
      AutovalidateMode? autovalidate = AutovalidateMode.onUserInteraction,
      this.placeholder,
      this.title,
      this.promptText,
      this.obscureText = false,
      this.passwordVisible = false,
      this.hideEye = false})
      : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidate,
          restorationId: restorationId,
          initialValue: controller?.text,
          builder: (FormFieldState<String> state) {
            final widget = state.widget as AuthorizationField;

            return widget._body(state, state.context);
          },
        );

  Widget _body(FormFieldState<String> state, BuildContext context) {
    return Column(
      children: [
        _title(context),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              width: 0.5,
              color: state.hasError
                  ? ColorConstants.statesError
                  : ColorConstants.stroke,
            ),
            color: ColorConstants.surfaceSecondary,
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: SizedBox(height: 25, child: _textField(state, context)),
          ),
        ),
        _errorField(state, context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    final style = Theme.of(context).textTheme.caption;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SizedBox(
        width: double.infinity,
        height: 16,
        child: Text(
          title ?? '',
          style: style?.merge(
            TextStyle(color: ColorConstants.onSurfaceWhite),
          ),
        ),
      ),
    );
  }

  Widget _errorField(FormFieldState<String> state, BuildContext context) {
    final color = promptText == null
        ? ColorConstants.statesError
        : ColorConstants.onSurfaceMedium;
    final style = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: state.hasError
          ? SizedBox(
              height: 16,
              width: double.infinity,
              child: Text(
                state.errorText ?? "",
                style: style?.merge(
                  TextStyle(color: color),
                ),
              ),
            )
          : promptText != null
              ? SizedBox(
                  height: 16,
                  width: double.infinity,
                  child: Text(
                    promptText ?? "",
                    style: style?.merge(
                      TextStyle(color: color),
                    ),
                  ),
                )
              : const SizedBox(height: 16),
    );
  }

  Widget _textField(FormFieldState<String> state, BuildContext context) {
    final mainStyle = Theme.of(context).textTheme.bodyText1;
    final color = state.hasError
        ? ColorConstants.statesError
        : ColorConstants.onSurfaceWhite;
    final eye = obscureText && !hideEye
        ? PlatformTextButton(
            onPressed: needShowPassword,
            padding: EdgeInsets.zero,
            child: Icon(
              passwordVisible
                  ? Icons.visibility_off
                  : Icons.remove_red_eye_rounded,
              color: ColorConstants.onSurfaceMedium,
            ),
          )
        : null;

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: constraints.maxWidth - (obscureText ? 42 : 0),
            child: PlatformTextField(
              controller: controller,
              obscureText: obscureText && !passwordVisible,
              obscuringCharacter: '*',
              style: mainStyle?.merge(
                TextStyle(color: color),
              ),
              scrollPadding: EdgeInsets.zero,
              hintText: placeholder,
              cupertino: (context, platform) {
                return CupertinoTextFieldData(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  padding: EdgeInsets.zero,
                );
              },
              material: (context, platform) {
                return MaterialTextFieldData(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 11),
                  ),
                );
              },
              onChanged: (value) {
                state.didChange(value);
              },
            ),
          ),
          if (eye != null) SizedBox(width: 40, child: eye)
        ],
      ),
    );
  }
}
