import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';

class SendButton extends StatelessWidget {
  final TextEditingController controller;
  const SendButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.text.isNotEmpty,
      child: InkWell(
        onTap: () {},
        child: Container(
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
      ),
    );
  }
}