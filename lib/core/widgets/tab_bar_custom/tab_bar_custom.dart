import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/values_manager.dart';

class TabBarCustom extends StatelessWidget {
  final List<Widget> widgets;
  final List<Tab> myTabs;
  final Function(int index)? onTap;
  final dynamic radius;

  const TabBarCustom(
      {required this.myTabs,
      required this.widgets,
      this.onTap,
      this.radius = AppSize.s8,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        animationDuration: const Duration(milliseconds: 800),
        length: myTabs.length,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.zero,
              height: AppSize.s40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(double.parse('$radius')),
                color: ColorManager.white1,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: TabBar(
                splashFactory: NoSplash.splashFactory,
                onTap: (int index) {
                  onTap == null ? null : onTap!(index);
                },
                tabs: myTabs,
                labelStyle: TextStyle(
                    fontSize: FontSize.s14, fontWeight: FontWeight.w600),
                enableFeedback: true,
                labelColor: ColorManager.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(double.parse('$radius')),
                  color: ColorManager.secondary,
                ),
                unselectedLabelColor: ColorManager.black,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
