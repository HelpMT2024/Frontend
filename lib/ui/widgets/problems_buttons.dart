import 'package:flutter/material.dart';
import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/ui/widgets/problem_case_button.dart';

class ProblemsButtons extends StatelessWidget {
  final List<ChildProblem> problems;

  const ProblemsButtons({super.key, required this.problems});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...problems.map(
          (e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ProblemCaseButton(problem: e),
            );
          },
        ),
      ],
    );
  }
}
