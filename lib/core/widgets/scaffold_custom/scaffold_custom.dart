import '../../utils/color_manager.dart';
import 'package:flutter/material.dart';

import '../app_bar/app_bar_custom.dart';

class ScaffoldCustom extends StatelessWidget {
  final Widget body;
  final Widget? drawer;

  final String? appBarTitle;
  final IconData? icon;
  final Function? onPressed;
  final Widget? bottomNavigationBar;
  final AppBarCustom? appBarCustom;
  final bool? condition;

  final bool? isExtend;

  final Widget? floatingActionButton;
  final Key? scaffoldKey;
  final Color? backgroundColor;

  const ScaffoldCustom({
    super.key,
    required this.body,
    this.scaffoldKey,
    this.appBarTitle,
    this.drawer,
    this.icon,
    this.onPressed,
    this.bottomNavigationBar,
    this.appBarCustom,
    this.condition = true,
    this.isExtend = false,
    this.backgroundColor = ColorManager.scaffoldColor,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: isExtend!,
        resizeToAvoidBottomInset: true,
        appBar: appBarCustom,
        drawer: drawer,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
