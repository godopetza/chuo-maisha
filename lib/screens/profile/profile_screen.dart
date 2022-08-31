import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          // print(BlocProvider.of<AuthBloc>(context).state);

          // return BlocProvider.of<AuthBloc>(context).state.status ==
          //         AuthStatus.unauthenticated
          //     ? OnboardingScreen()
          //     : ProfileScreen();
          return Text('fix this screen');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
