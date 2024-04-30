import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/services/router/faults_router.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';

class ProblemCaseButton extends StatelessWidget {
  final ChildProblem problem;

  const ProblemCaseButton({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return CustomButton(
      height: 48,
      title: CustomButtonTitle(
        text: null,
        widget: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.nearby_error,
                size: 20,
                color: ColorConstants.warningColor,
              ),
              const SizedBox(width: 6),
              Text(
                problem.name,
                style: styles.labelLarge?.copyWith(
                  color: ColorConstants.onSurfaceWhite,
                ),
              ),
            ],
          ),
        ),
      ),
      mainColor: ColorConstants.onSurfaceSecondary,
      state: CustomButtonStates.filled,
      onPressed: () => Navigator.of(context).pushNamed(
        FaultsRouteKeys.problemCaseScreen,
        arguments: problem,
      ),
    );
  }
}
