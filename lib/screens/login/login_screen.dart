import 'package:chuomaisha/screens/home/home_screen.dart';
import 'package:chuomaisha/screens/onboarding/onboarding_screen.dart';
import 'package:chuomaisha/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../cubits/cubits.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.authenticated
            ? HomeScreen()
            : LoginScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        hasActions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailInput(),
            const SizedBox(height: 10),
            PasswordInput(),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'LOGIN',
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.read<LoginCubit>().loginWithCredentials();
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'SIGN UP',
              beginColor: Theme.of(context).colorScheme.secondary,
              endColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
