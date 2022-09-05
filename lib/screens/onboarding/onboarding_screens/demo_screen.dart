import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Demo extends StatelessWidget {
  final TabController tabController;
  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextHeader(
                  text: 'What\'s your gender?',
                  tabController: tabController,
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  text: 'MALE',
                  tabController: tabController,
                ),
                CustomCheckbox(
                  text: 'FEMALE',
                  tabController: tabController,
                ),
                const SizedBox(height: 20),
                CustomTextHeader(
                  text: 'What\'s your Age?',
                  tabController: tabController,
                ),
                CustomTextField(
                  hint: 'ENTER YOUR AGE',
                  controller: controller,
                ),
              ],
            ),
            Column(
              children: [
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 3,
                  selectedColor: Theme.of(context).primaryColor,
                  unselectedColor: Theme.of(context).backgroundColor,
                ),
                const SizedBox(height: 10),
                CustomButton(tabController: tabController, text: 'NEXT STEP'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
