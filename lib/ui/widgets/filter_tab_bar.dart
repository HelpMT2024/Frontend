import 'package:flutter/widgets.dart';
import 'package:help_my_truck/ui/widgets/custom_tab_button.dart';

class FilterTabBar extends StatefulWidget {
  final List<String> titles;

  const FilterTabBar({super.key, required this.titles});

  @override
  State<FilterTabBar> createState() => FilterTabBarState();
}

class FilterTabBarState extends State<FilterTabBar> {
  List<CustomTabButton> buttons = [];
  final double spacing = 8;

  @override
  void initState() {
    createButtons(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: row(),
      ),
    );
  }

  void selectionCallback(int index) {
    setState(() {
      createButtons(index);
    });
  }

  void createButtons(int tapIndex) {
    var index = 0;
    buttons.clear();
    for (var title in widget.titles) {
      var button = CustomTabButton(
        index: index,
        title: title,
        callback: selectionCallback,
        isSelected: tapIndex == index,
      );
      buttons.add(button);
      index++;
    }
  }

  List<Widget> row() {
    return buttons.map((button) {
      return Row(
        children: [
          button,
          SizedBox(
            width: spacing,
          ),
        ],
      );
    }).toList();
  }
}
