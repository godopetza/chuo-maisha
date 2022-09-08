import 'package:chuomaisha/config/app_router.dart';
import 'package:chuomaisha/config/theme.dart';
import 'package:chuomaisha/cubits/signup/signup_cubit.dart';
import 'package:chuomaisha/repositories/repositories.dart';
import 'package:chuomaisha/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
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
          create: (context) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc()
              ..add(
                LoadUsers(
                    users: User.users.where((user) => user.uid != 1).toList()),
              ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              databaseRepository: DatabaseRepository(),
              storageRepository: StorageRepository(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Chuo Maisha',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
