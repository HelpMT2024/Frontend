import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  final List<Widget> buttons;

  const ButtonGroup({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...buttons.asMap().entries.map((e) {
            final index = e.key;
            final button = e.value;
            final isLast = index == buttons.length - 1;
            final isOdd = index % 2 == 0;
            final isEven = index % 2 == 1;
            final isSingle = buttons.length == 1;
            final isLastOdd = isLast && isOdd;
            final isLastEven = isLast && isEven;
            final isLastSingle = isLast && isSingle;

            return SizedBox(
              width: isLastSingle
                  ? constraints.maxWidth
                  : isLastOdd
                      ? constraints.maxWidth
                      : isLastEven
                          ? constraints.maxWidth / 2 - 4
                          : constraints.maxWidth / 2 - 4,
              child: button,
            );
          }),
        ],
      );
    });
  }
}
