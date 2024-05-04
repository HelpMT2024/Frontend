import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_gradient_bg_decorator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
