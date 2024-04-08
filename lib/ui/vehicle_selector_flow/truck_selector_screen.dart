import 'package:flutter/material.dart';
import 'package:help_my_truck/ui/lib/nav_bar/main_navigation_bar.dart';

class TruckSelectorScreen extends StatefulWidget {
  const TruckSelectorScreen({super.key});

  @override
  State<TruckSelectorScreen> createState() => _TruckSelectorScreenState();
}

class _TruckSelectorScreenState extends State<TruckSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      extendBody: true,
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
      ),
      body: Container(),
    );
  }
}
