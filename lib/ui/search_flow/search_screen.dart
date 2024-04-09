import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';
import 'package:help_my_truck/ui/shared/text_box_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchModalController {
  final spnFocus = FocusNode();
  final fmiFocus = FocusNode();
  double _offset = 0;
  bool _isShowSearch = false;
  bool _isShowMaxSearch = false; 
  double get offset => _offset;
  bool get isShowSearch => _isShowSearch;
  bool get isShowMaxSearch => _isShowMaxSearch;
  final ValueNotifier<bool> hasFocus = ValueNotifier<bool>(false);
  final panelController = PanelController();

  SearchModalController() {
    spnFocus.addListener(() => _updateFocusValue);
    fmiFocus.addListener(() => _updateFocusValue);
  }

  void dispose() {
    spnFocus.removeListener(() => _updateFocusValue);
    fmiFocus.removeListener(() => _updateFocusValue);
  }

  void unfocus() {
    spnFocus.unfocus();
    fmiFocus.unfocus();
  }

  Future<void> processOffset(double offset) async {
    _offset = offset;
    _isShowSearch = offset > 0;
    _isShowMaxSearch = offset == 1;
  }

  void _updateFocusValue() {
    hasFocus.value = spnFocus.hasFocus || fmiFocus.hasFocus;
  }
}

class SearchScreen extends StatefulWidget {
  final SearchModalController searchModalController;
  final double maxHeight;
  final double bottom;
  final bool isShowSearch;
  final bool isShowMaxSearch;

  const SearchScreen({
    super.key,
    required this.maxHeight,
    required this.bottom,
    required this.isShowSearch,
    required this.isShowMaxSearch,
    required this.searchModalController
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _spn;
  String? _fmi;

  void _onSearchTap() {

  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      final maxSearchHeight = widget.maxHeight - 32 - 36 - (widget.bottom != 1 ? 32 : 16);
      final dependandHeight = widget.maxHeight * widget.searchModalController.offset;

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.isShowMaxSearch ? maxSearchHeight : dependandHeight > 0 ? dependandHeight : 0
        ),
        child: _body(l10n),
      );
    });
  }

  Widget _body(AppLocalizations? l10n) {
    return Container(
      color: ColorConstants.surfacePrimaryDark,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextBoxField(
              title: l10n?.spn_number_title ?? 'SPN Number',
              height: 40,
              maxLines: 1,
              focusNode: widget.searchModalController.spnFocus,
              keyboardType: TextInputType.number,
              hintText: l10n?.enter_hint.replaceAll('\$1', l10n.spn_number_title) ?? 'Enter SPN Number',
              onSaved: (value) => _spn = value,
              validator: (value) => value != null ? null : "Can't be empty"
            ),
            const SizedBox(height: 2),
            TextBoxField(
              title: l10n?.fmi_number_title ?? 'FMI Number',
              height: 40,
              maxLines: 1,
              focusNode: widget.searchModalController.fmiFocus,
              keyboardType: TextInputType.number,
              hintText: l10n?.enter_hint.replaceAll('\$1', l10n.fmi_number_title) ?? 'Enter FMI Number',
              onSaved: (value) => _fmi = value,
              validator: (value) => value != null ? null : "Can't be empty"
            ),
            const SizedBox(height: 8),
            CustomButton(
              title: CustomButtonTitle(text: l10n?.search_fault_code_button ?? 'Search Fault Code'),
              mainColor: ColorConstants.onSurfaceWhite,
              textColor: ColorConstants.onSurfaceHigh,
              state: CustomButtonStates.filled,
              onPressed: _onSearchTap
            )
          ],
        ),
      ),
    );
  }
}