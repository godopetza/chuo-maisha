import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class Location extends StatelessWidget {
  final TabController tabController;
  const Location({
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextHeader(text: 'Where Are You?'),
                      CustomTextField(
                        hint: 'ENTER YOUR LOCATION',
                        onChanged: (value) {
                          context.read<OnboardingBloc>().add(
                                UpdateUser(
                                  user: state.user.copyWith(location: value),
                                ),
                              );
                        },
                      ),
                      const CustomTextHeader(text: 'What are you looking for?'),
                      CustomCheckbox(
                        text: 'WORK',
                        value: state.user.interestedIn == 'WORK',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(UpdateUser(
                              user: state.user.copyWith(interestedIn: 'WORK')));
                        },
                      ),
                      CustomCheckbox(
                        text: 'HIRING',
                        value: state.user.interestedIn == 'HIRING',
                        onChanged: (bool? newValue) {
                          context.read<OnboardingBloc>().add(UpdateUser(
                              user: state.user.copyWith(interestedIn: 'HIRING')));
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 6,
                        currentStep: 6,
                        selectedColor: Theme.of(context).primaryColor,
                        unselectedColor: Theme.of(context).backgroundColor,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(tabController: tabController, text: 'DONE'),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
