import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
    this.automaticallyImplyLeading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Expanded(
            child: SvgPicture.asset('assets/icons/logo.svg', height: 50),
          ),
          Expanded(
              flex: 2,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ))
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon:
                      Icon(Icons.person, color: Theme.of(context).primaryColor))
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
