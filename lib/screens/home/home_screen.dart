import 'package:flutter/material.dart';
import 'package:chuomaisha/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../blocs/swipe/swipe_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SwipeLoaded) {
          return SwipeLoadedHomeScreen(state: state);
        }
        if (state is SwipeMatched) {
          return SwipeMatchedHomeScreen(state: state);
        }
        if (state is SwipeError) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: Text('There aren\'t any more users.',
                  style: Theme.of(context).textTheme.headline4),
            ),
          );
        } else {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Text('Something Went Wrong!'),
          );
        }
      },
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeLoaded state;

  @override
  Widget build(BuildContext context) {
    var userCount = state.users.length;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DISCOVER',
      ),
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              Navigator.pushNamed(context, '/users', arguments: state.users[0]);
            },
            child: Draggable(
              feedback: UserCard(user: state.users[0]),
              childWhenDragging: (userCount > 1)
                  ? UserCard(user: state.users[1])
                  : Container(),
              child: UserCard(user: state.users[0]),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  context
                      .read<SwipeBloc>()
                      .add(SwipeLeft(user: state.users[0]));
                } else {
                  context
                      .read<SwipeBloc>()
                      .add(SwipeRight(user: state.users[0]));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeLeft(user: state.users[0]));
                  },
                  child: ChoiceButton(
                      width: 60,
                      height: 60,
                      size: 25,
                      hasGradient: false,
                      color: Theme.of(context).colorScheme.secondary,
                      icon: Icons.clear_rounded),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeRight(user: state.users[0]));
                  },
                  child: const ChoiceButton(
                      width: 80,
                      height: 80,
                      size: 30,
                      hasGradient: true,
                      color: Colors.white,
                      icon: Icons.favorite),
                ),
                ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    hasGradient: false,
                    color: Theme.of(context).primaryColor,
                    icon: Icons.watch_later),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeMatched state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats, it\'s a match!',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20),
            Text(
              'You and ${state.user.name} have liked each other!',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'SEND A MESSAGE',
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'CONTINUE SWIPING',
              beginColor: Theme.of(context).primaryColor,
              endColor: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              onPressed: () {
                context.read<SwipeBloc>().add(
                      LoadUsers(user: context.read<AuthBloc>().state.user!),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
