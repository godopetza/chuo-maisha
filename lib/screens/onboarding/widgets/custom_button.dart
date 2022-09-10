import 'package:chuomaisha/blocs/blocs.dart';
import 'package:chuomaisha/cubits/signup/signup_cubit.dart';
import 'package:chuomaisha/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index == 5) {
            Navigator.pushNamed(context, '/');
            
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 2) {
            await context.read<SignupCubit>().signupWithCredentials();

            User user = User(
              name: '',
              uid: context.read<SignupCubit>().state.user!.uid,
              role: '',
              interestedIn: '',
              gender: '',
              age: 0,
              location: '',
              imageUrls: [],
              jobTitle: '',
              skills: [],
              matches: [],
              swipeLeft: [],
              swipeRight: [],
              bio: '',
            );

            context.read<OnboardingBloc>().add(
                  StartOnboarding(user: user),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
