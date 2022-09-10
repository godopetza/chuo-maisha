import 'package:chuomaisha/repositories/repositories.dart';
import 'package:chuomaisha/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<MatchBloc>(
        create: (context) => MatchBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(
            LoadMatches(user: context.read<AuthBloc>().state.user!),
          ),
        child: MatchesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'MATCHES'),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MatchLoaded) {
            final inactiveMatches =
                state.matches.where((match) => match.chat == null).toList();

            final activeMatches =
                state.matches.where((match) => match.chat != null).toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Likes',
                        style: Theme.of(context).textTheme.headline4),
                    MatchesList(inactiveMatches: inactiveMatches),
                    const SizedBox(height: 10),
                    Text('Your Chats',
                        style: Theme.of(context).textTheme.headline4),
                    ChatsList(activeMatches: activeMatches),
                  ],
                ),
              ),
            );
          }
          if (state is MatchUnavailable) {
            return Column(
              children: [
                Text(
                  'No matches yet.',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'BACK TO SWIPING',
                  beginColor: Theme.of(context).colorScheme.secondary,
                  endColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({
    Key? key,
    required this.activeMatches,
  }) : super(key: key);

  final List<Match> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activeMatches.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/chat',
                  arguments: activeMatches[index]);
            },
            child: Row(
              children: [
                UserImageSmall(
                    height: 70,
                    width: 70,
                    imageUrl: activeMatches[index].matchedUser.imageUrls[0]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeMatches[index].matchedUser.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat![0].messages[0].message,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat![0].messages[0].timeString,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({
    Key? key,
    required this.inactiveMatches,
  }) : super(key: key);

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: inactiveMatches.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserImageSmall(
                    height: 70,
                    width: 70,
                    imageUrl: inactiveMatches[index].matchedUser.imageUrls[0]),
                Text(
                  inactiveMatches[index].matchedUser.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            );
          }),
    );
  }
}
