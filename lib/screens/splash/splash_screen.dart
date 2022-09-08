import 'dart:async';

import 'package:chuomaisha/screens/home/home_screen.dart';
import 'package:chuomaisha/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/blocs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('Listener');

          if (state.status == AuthStatus.unauthenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  OnboardingScreen.routeName,
                  ModalRoute.withName('/onboarding')),
            );
          } else if (state.status == AuthStatus.authenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamed(HomeScreen.routeName),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  'CHUOMAISHA',
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
