import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentsScreen extends StatefulWidget {
  final _controller = TextEditingController();

  CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey _textFieldKey = GlobalKey();
  double? _height;

  void _afterLayout(_) {
    final RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      _height = renderBox.size.height;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height - 122,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: ColorConstants.surfacePrimaryDark,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(l10n, styles),
          const Expanded(child: SingleChildScrollView()),
          _footer(l10n, styles),
          SizedBox(height: keyBoardHeight),
        ],
      ),
    );
  }

  _header(AppLocalizations? l10n, TextTheme styles) {
    return Stack(
      children: [
        _title(l10n, styles),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: ColorConstants.surfaceSecondary,
              ),
              child: Icon(
                Icons.close,
                size: 20,
                color: ColorConstants.onSurfaceMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footer(AppLocalizations? l10n, TextTheme styles) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.surfacePrimaryDark,
        border: Border(
          top: BorderSide(
            color: ColorConstants.stroke,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: _textField(l10n, styles),
    );
  }

  Widget _title(AppLocalizations? l10n, TextTheme styles) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: ColorConstants.onSurfaceMedium,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n?.comments_title ?? '',
              style: styles.titleMedium
                  ?.copyWith(color: ColorConstants.onSurfaceWhite),
            ),
            const SizedBox(height: 15),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: ColorConstants.stroke,
            ),
          ],
        ),
      ],
    );
  }

  Widget _textField(AppLocalizations? l10n, TextTheme styles) {
    return Container(
      key: _textFieldKey,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          width: 0.5,
          color: ColorConstants.stroke,
        ),
        color: ColorConstants.surfaceSecondary,
        shape: BoxShape.rectangle,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: PlatformTextField(
        style: styles.bodyMedium?.merge(
          TextStyle(color: ColorConstants.onSurfaceWhite),
        ),
        scrollPadding: EdgeInsets.zero,
        hintText: 'Add a comment...',
        controller: widget._controller,
        expands: true,
        maxLines: null,
        minLines: null,
        cupertino: (context, platform) {
          return CupertinoTextFieldData(
            controller: widget._controller,
            suffixMode: OverlayVisibilityMode.editing,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (_height != null) SizedBox(height: _height!),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: ColorConstants.surfaceWhite,
                  ),
                  child: Flexible(
                    child: Icon(
                      Icons.send,
                      size: 16,
                      color: ColorConstants.surfacePrimaryDark,
                    ),
                  ),
                ),
              ],
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: const BoxDecoration(color: Colors.transparent),
            padding: const EdgeInsets.symmetric(vertical: 10),
            placeholderStyle: styles.bodyMedium?.merge(
              TextStyle(color: ColorConstants.onSurfaceWhite80),
            ),
          );
        },
        material: (context, platform) {
          return MaterialTextFieldData(
            controller: widget._controller,
            decoration: InputDecoration(
              suffix: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: ColorConstants.surfaceWhite,
                ),
                child: Icon(
                  Icons.send,
                  size: 16,
                  color: ColorConstants.surfacePrimaryDark,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              hintStyle: styles.bodyMedium?.merge(
                TextStyle(color: ColorConstants.onSurfaceMedium),
              ),
            ),
          );
        },
      ),
    );
  }
}
