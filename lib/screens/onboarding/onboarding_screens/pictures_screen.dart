import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;
  const Pictures({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  text: 'Add 2 or more photos', tabController: tabController),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                  CustomImageContainer(
                    tabController: tabController,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,  
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              const SizedBox(height: 10),
              CustomButton(tabController: tabController, text: 'NEXT STEP'),
            ],
          ),
        ],
      ),
    );
  }
}
