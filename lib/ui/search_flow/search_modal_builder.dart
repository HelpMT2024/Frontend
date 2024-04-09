import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchModalBuilder extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final SearchModalController searchModalController;

  const SearchModalBuilder({
    super.key, 
    required this.builder,
    required this.searchModalController
  });

  @override
  _SearchModalBuilderState createState() => _SearchModalBuilderState();
}

class _SearchModalBuilderState extends State<SearchModalBuilder> {
  bool get _isShowSearch => widget.searchModalController.isShowSearch;
  bool get _isShowMaxSearch => widget.searchModalController.isShowMaxSearch;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            widget.builder(context),
            _panel(constraints.maxHeight)
          ],
        );
      }
    );
  }

  Widget _panel(double height) {
    final top = MediaQuery.of(context).viewPadding.top;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final bottom =
        isKeyboardOpen ? 1.0 : MediaQuery.of(context).viewPadding.bottom;
    final maxHeight = MediaQuery.of(context).size.height - top;

    return SlidingUpPanel(
      isDraggable: true,
      controller: widget.searchModalController.panelController,
      minHeight: 0,
      maxHeight: !_isShowSearch ? 0 : maxHeight,
      snapPoint: 0.5,
      panel: _isShowSearch
          ? SearchScreen(
              isShowSearch: _isShowSearch,
              isShowMaxSearch: _isShowMaxSearch,
              maxHeight: height,
              bottom: bottom,
              searchModalController: widget.searchModalController
            )
          : const SizedBox(),
      color: Colors.transparent,
      boxShadow: const [],
      parallaxOffset: 0.4,
      onPanelSlide: (position) {
        if(_isShowMaxSearch && widget.searchModalController.hasFocus.value) {
          widget.searchModalController.unfocus();
        }
      }
    );
  }
}
