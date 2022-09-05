import 'package:chuomaisha/blocs/auth/auth_bloc.dart';
import 'package:chuomaisha/blocs/swipe/swipe_bloc.dart';
import 'package:chuomaisha/config/app_router.dart';
import 'package:chuomaisha/config/theme.dart';
import 'package:chuomaisha/repositories/repositories.dart';
import 'package:chuomaisha/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsers(users: User.users),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Chuo Maisha',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: OnboardingScreen.routeName,
        ),
      ),
    );
  }
}
