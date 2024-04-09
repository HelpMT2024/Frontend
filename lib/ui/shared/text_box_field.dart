import 'package:help_my_truck/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TextBoxField extends FormField<String> {
  final String title;
  final TextEditingController? controller;
  final int? maxSymbols;
  final String? description;
  final double? height;
  final int? maxLines;
  final String? hintText;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  TextBoxField({
    Key? key,
    required FormFieldSetter<String> onSaved,
    required this.title,
    required FormFieldValidator<String> validator,
    this.maxSymbols,
    this.description,
    this.controller,
    this.height,
    this.maxLines,
    this.hintText,
    this.readOnly,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    AutovalidateMode? autovalidate = AutovalidateMode.onUserInteraction,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: controller?.text,
          autovalidateMode: autovalidate,
          builder: (FormFieldState<String> state) {
            return _TextBoxField(
              controller: controller,
              inputFormatters: inputFormatters,
              state: state,
              title: title,
              maxLenght: maxSymbols,
              description: description,
              height: height ?? 80,
              maxLines: maxLines,
              hintText: hintText,
              focusNode: focusNode,
              keyboardType: keyboardType,
              readOnly: readOnly ?? false,
            );
          },
        );
}

class _TextBoxField extends StatefulWidget {
  final String title;
  final int? maxLenght;
  final String? description;
  final TextEditingController? controller;
  final FormFieldState<String> state;
  final double height;
  final int? maxLines;
  final String? hintText;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const _TextBoxField({
    Key? key,
    required this.state,
    required this.title,
    required this.maxLenght,
    required this.height,
    this.description,
    this.controller,
    this.maxLines,
    this.hintText,
    this.readOnly,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters
  }) : super(key: key);

  @override
  State<_TextBoxField> createState() => _TextBoxFieldState();
}

class _TextBoxFieldState extends State<_TextBoxField> {

  Color _borderColor = ColorConstants.stroke;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _title(styles),
        const SizedBox(height: 2),
        _textField(),
        const SizedBox(height: 2),
        _errorField(widget.state, styles)
      ],
    );
  }

  SizedBox _title(TextTheme styles) {
    return SizedBox(
      height: 16,
      width: double.infinity,
      child: Text(
        widget.title,
        maxLines: 1,
        style: styles.caption?.merge(
          TextStyle(color: ColorConstants.onSurfaceWhite),
        ),
      ),
    );
  }

  Widget _errorField(FormFieldState<String> state, TextTheme styles) {
    final hasError = state.hasError;

    return hasError || widget.description != null 
        ? SizedBox(
            child: Text(
              hasError ? state.errorText ?? "" : widget.description ?? '',
              maxLines: 3,
              style: styles.caption?.merge(
                const TextStyle(color: Colors.red),
              ),
            ),
          )
        : const SizedBox(height: 16);
  }

  Widget _textField() {
    final styles = Theme.of(context).textTheme;

    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          setState(() {
            _borderColor = focus
                ? ColorConstants.onSurfacePrimaryLighter
                : ColorConstants.stroke;
          });
        },
        focusNode: FocusNode(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: ColorConstants.surfaceSecondary,
          ),
          height: widget.height,
          child: PlatformTextField(
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            focusNode: widget.focusNode,
            hintText: widget.hintText,
            cursorColor: _borderColor,
            onChanged: (p0) {
              widget.state.didChange(p0);
            },
            controller: widget.controller,
            maxLines: widget.maxLines,
            maxLength: widget.maxLenght,
            textAlignVertical: TextAlignVertical.top,
            material: (context, platform) {
              return MaterialTextFieldData(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                    6,
                    (widget.maxLines == null ? 3 : -6),
                    6,
                    12,
                  ),
                  counterText: '',
                  hintStyle: styles.bodyText1?.merge(
                    TextStyle(color: ColorConstants.onSurfaceMedium),
                  ),
                ),
              );
            },
            cupertino: (context, platform) {
              return CupertinoTextFieldData(
                textAlignVertical: widget.maxLines != null
                    ? TextAlignVertical.center
                    : TextAlignVertical.top,
                decoration: const BoxDecoration(border: null),
                padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
              );
            },
            keyboardType: widget.keyboardType,
            style: TextStyle(color: ColorConstants.onSurfaceWhite),
          ),
        ),
      ),
    );
  }
}
