import 'package:chuomaisha/screens/onboarding/onboarding_screens/email_verification_screen.dart';
import 'package:chuomaisha/screens/onboarding/onboarding_screens/screens.dart';
import 'package:chuomaisha/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OnboardingScreen(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    // Tab(text: 'Location')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'C-MAISHA',
            hasActions: false,
          ),
          body: TabBarView(
            children: [
              Start(
                tabController: tabController,
              ),
              Email(
                tabController: tabController,
              ),
              EmailVerification(
                tabController: tabController,
              ),
              Demo(
                tabController: tabController,
              ),
              Pictures(
                tabController: tabController,
              ),
              Bio(
                tabController: tabController,
              ),
            ],
          ),
        );
      }),
    );
  }
}
