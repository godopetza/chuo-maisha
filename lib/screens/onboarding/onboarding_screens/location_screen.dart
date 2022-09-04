import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final TabController tabController;
  const Location({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 50,
      ),
      child: Container(),
    );
  }
}
