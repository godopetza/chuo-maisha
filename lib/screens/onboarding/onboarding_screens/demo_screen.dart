import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class Demo extends StatelessWidget {
  final TabController tabController;
  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OnboardingLoaded) {
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
                    const CustomTextHeader(
                      text: 'What\'s your gender?',
                    ),
                    const SizedBox(height: 15),
                    CustomCheckbox(
                      text: 'MALE',
                      value: state.user.gender == 'Male',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(gender: 'Male')));
                      },
                    ),
                    CustomCheckbox(
                      text: 'FEMALE',
                      value: state.user.gender == 'Female',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(gender: 'Female')));
                      },
                    ),
                    const SizedBox(height: 3),
                    const CustomTextHeader(
                      text: 'What\'s your Age?',
                    ),
                    CustomTextField(
                      hint: 'ENTER YOUR AGE',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  age: int.parse(value),
                                ),
                              ),
                            );
                      },
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
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }
}
