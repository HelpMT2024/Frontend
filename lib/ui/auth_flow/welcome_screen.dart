import 'package:flutter/material.dart';

import '../widgets/app_gradient_bg_decorator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        decoration: appGradientBgDecoration,
      ),
    );
  }
}
