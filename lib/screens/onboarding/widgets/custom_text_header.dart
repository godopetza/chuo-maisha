import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;
  final TabController tabController;

  const CustomTextHeader({
    Key? key,
    required this.text,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontWeight: FontWeight.normal,
          ),
    );
  }
}
