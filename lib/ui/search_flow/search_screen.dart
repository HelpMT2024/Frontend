import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/child_type.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/system.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/services/router/vehicle_selector_router.dart';
import 'package:help_my_truck/ui/shared/custom_button.dart';
import 'package:help_my_truck/ui/shared/text_box_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchModalController {
  final VehicleProvider provider;

  final spnFocus = FocusNode();
  final fmiFocus = FocusNode();

  final ValueNotifier<bool> hasFocus = ValueNotifier<bool>(false);
  final panelController = PanelController();
  final bool needHideBackButton;
  final isInSearch = BehaviorSubject<bool>.seeded(false);
  final searchResult = BehaviorSubject<SearchFault?>.seeded(null);
  SearchFault? _initialSearchResult;

  double _offset = 0;
  bool _isShowSearch = false;
  bool _isShowMaxSearch = false;
  double get offset => _offset;
  bool get isShowSearch => _isShowSearch;
  bool get isShowMaxSearch => _isShowMaxSearch;

  SearchModalController({
    required this.provider,
    SearchFault? searchFault,
    this.needHideBackButton = false,
  }) {
    if (searchFault != null) {
      _initialSearchResult = searchFault;
      searchResult.add(searchFault);
      isInSearch.add(true);
    }
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

  void search(String spn, String fmi) {
    isInSearch.add(true);
    if (_initialSearchResult != null) {
      searchResult.add(_initialSearchResult);
      return;
    }
    provider
        .searchFault(spn, fmi)
        .then((value) => searchResult.add(value))
        .catchError((error) {
      searchResult.addError(error);
    });
  }

  void _updateFocusValue() {
    hasFocus.value = spnFocus.hasFocus || fmiFocus.hasFocus;
  }
}

class SearchScreen extends StatefulWidget {
  final SearchModalController searchModalController;

  const SearchScreen({super.key, required this.searchModalController});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _spn;
  String? _fmi;

  void _onSearchTap() {
    ModalRoute.withName(VehicleSelectorRouteKeys.truckSelector);

    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      widget.searchModalController.search(_spn!, _fmi!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _topPadding(),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(color: ColorConstants.surfacePrimaryDark),
          LayoutBuilder(builder: (context, snapshot) {
            return SingleChildScrollView(
              child: SizedBox(
                height: snapshot.maxHeight + (isKeyboard ? keyboardHeight : 0),
                child: _loadingStreamBuilder(l10n),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _loadingStreamBuilder(AppLocalizations? l10n) {
    return StreamBuilder<bool>(
      stream: widget.searchModalController.isInSearch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data == true ? _searchBody() : _body(l10n);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _searchBody() {
    return StreamBuilder<SearchFault?>(
      stream: widget.searchModalController.searchResult,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 95),
          child: snapshot.hasData
              ? _successBody(snapshot.data!)
              : snapshot.hasError == true
                  ? _notFound()
                  : _loader(),
        );
      },
    );
  }

  Center _loader() {
    return const Center(
      child: Loadable(
        forceLoad: true,
        child: SizedBox(height: 40, width: 40),
      ),
    );
  }

  Widget _successBody(SearchFault data) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        _title(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16, width: double.infinity),
              if (!data.showAsPdf) _faultButton(l10n, data),
              ..._detailsButtons(data)
            ],
          ),
        ),
      ],
    );
  }

  Iterable<Widget> _detailsButtons(SearchFault data) {
    return data.linkedFrom.map((e) {
      switch (e.type) {
        case SearchFaultDetailType.problemCase:
          return _button(e.name, () {
            final arg = ChildProblem(id: e.id, name: e.name);

            Navigator.of(context).pushNamed(
              FaultsRouteKeys.problemCaseScreen,
              arguments: arg,
            );
          });
        case SearchFaultDetailType.component:
          return _button(e.name, () {
            final arg = ChildrenComponent(
              id: e.id,
              name: e.name,
              image: null,
              type: ChildType.standart,
            );

            Navigator.of(context).pushNamed(
              VehicleSelectorRouteKeys.componentObserver,
              arguments: arg,
            );
          });
        case SearchFaultDetailType.part:
          return _button(e.name, () {
            final arg = ChildrenPart(id: e.id, name: e.name, image: null);
            Navigator.of(context).pushNamed(
              VehicleSelectorRouteKeys.partObserver,
              arguments: arg,
            );
          });

        case SearchFaultDetailType.warningLight:
          return Container();
      }
    });
  }

  Widget _faultButton(AppLocalizations? l10n, SearchFault data) {
    if (data.spnCode == null || data.fmiCodes == null || data.id == null) {
      return Container();
    }
    return _button(l10n?.open_page_with_fault_code ?? '', () {
      final arg = ChildFault(
        id: data.id!,
        spnCode: data.spnCode!,
        fmiCodes: data.fmiCodes!,
        showAsPdf: false,
      );
      Navigator.of(context).pushNamed(
        FaultsRouteKeys.faultScreen,
        arguments: arg,
      );
    });
  }

  LayoutBuilder _button(String text, Function() onTap) {
    return LayoutBuilder(builder: (context, consytaints) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CustomButton(
          height: 48,
          title: CustomButtonTitle(
            text: null,
            widget: SizedBox(
              width: consytaints.maxWidth - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorConstants.onSurfaceWhite,
                        ),
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: ColorConstants.onSurfaceWhite,
                  ),
                ],
              ),
            ),
          ),
          state: CustomButtonStates.filled,
          mainColor: ColorConstants.surfaceSecondary,
          onPressed: onTap,
        ),
      );
    });
  }

  Widget _title() {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!widget.searchModalController.needHideBackButton)
          PlatformIconButton(
            onPressed: () => widget.searchModalController.isInSearch.add(false),
            icon:
                Icon(CupertinoIcons.back, color: ColorConstants.onSurfaceWhite),
          ),
        const Spacer(),
        Text(
          _spn == null ? l10n?.possible_causes ?? '' : 'SPN $_spn, FMI $_fmi',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite,
              ),
        ),
        const Spacer(),
        if (!widget.searchModalController.needHideBackButton)
          PlatformIconButton(
            onPressed: () => widget.searchModalController.isInSearch.add(false),
            icon: const Icon(
              CupertinoIcons.battery_empty,
              color: Colors.transparent,
            ),
          ),
      ],
    );
  }

  Widget _notFound() {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _title(),
        const Spacer(),
        Text(
          l10n?.oops ?? '',
          style: styles.headlineSmall?.copyWith(
            color: ColorConstants.surfaceWhite,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n?.no_result_found ?? '',
          style: styles.titleMedium?.copyWith(
            color: ColorConstants.surfaceWhite,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          textAlign: TextAlign.center,
          l10n?.no_search_result_description ?? '',
          style: styles.bodyMedium?.copyWith(
            color: ColorConstants.surfaceWhite,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _body(AppLocalizations? l10n) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.surfacePrimaryDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 24),
            _spnTextBox(l10n),
            const SizedBox(height: 4),
            _fmiTextBox(l10n),
            const SizedBox(height: 8),
            CustomButton(
              title: CustomButtonTitle(
                text: l10n?.search_fault_code_button ?? 'Search Fault Code',
              ),
              mainColor: ColorConstants.onSurfaceWhite,
              textColor: ColorConstants.onSurfaceHigh,
              state: CustomButtonStates.filled,
              onPressed: _onSearchTap,
            )
          ],
        ),
      ),
    );
  }

  Widget _topPadding() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.surfacePrimaryDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SizedBox(
        height: 36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: ColorConstants.onSurfaceMedium.withAlpha(102),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextBoxField _spnTextBox(AppLocalizations? l10n) {
    return TextBoxField(
      title: l10n?.spn_number_title ?? 'SPN Number',
      height: 40,
      maxLines: 1,
      focusNode: widget.searchModalController.spnFocus,
      keyboardType: TextInputType.number,
      hintText: l10n?.enter_hint.replaceAll('\$1', l10n.spn_number_title) ??
          'Enter SPN Number',
      onSaved: (value) => _spn = value,
      validator: (value) => value?.isNotEmpty == true ? null : "Can't be empty",
    );
  }

  TextBoxField _fmiTextBox(AppLocalizations? l10n) {
    return TextBoxField(
      title: l10n?.fmi_number_title ?? 'FMI Number',
      height: 40,
      maxLines: 1,
      focusNode: widget.searchModalController.fmiFocus,
      keyboardType: TextInputType.number,
      hintText: l10n?.enter_hint.replaceAll('\$1', l10n.fmi_number_title) ??
          'Enter FMI Number',
      onSaved: (value) => _fmi = value,
      validator: (value) => value?.isNotEmpty == true ? null : "Can't be empty",
    );
  }
}
