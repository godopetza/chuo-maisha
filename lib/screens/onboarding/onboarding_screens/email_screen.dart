import 'package:chuomaisha/cubits/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;
  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomTextHeader(
                      text: 'What\'s your email Address?',
                      tabController: tabController),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                      print(state.email);
                    },
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  CustomTextHeader(
                      text: 'Choose a Password', tabController: tabController),
                  CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                      print(state.password);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    tabController: tabController,
                    text: 'NEXT STEP',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
