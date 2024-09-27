import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/values_manager.dart';

class ShimmerHorizontal extends StatelessWidget {
  const ShimmerHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (AppSize.s100 * 1.7).h,
      child: ShimmerCustom(
          child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: AppPadding.p20),
          height: (AppSize.s100 * 1.7).h,
          width: AppSize.s100.w,
          decoration: BoxDecoration(
            color: ColorManager.grey,
            borderRadius: BorderRadius.circular(AppSize.s20.r),
          ),
        ),
        itemCount: 4,
      )),
    );
  }
}

class ShimmerVertical extends StatelessWidget {
  const ShimmerVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (AppSize.s100 * 1.7).h,
      child: ShimmerCustom(
          child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: AppPadding.p20),
          height: (AppSize.s100 * 1.7).h,
          // width: AppSize.s100.w,
          decoration: BoxDecoration(
            color: ColorManager.grey,
            borderRadius: BorderRadius.circular(AppSize.s20.r),
          ),
        ),
        itemCount: 4,
      )),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCustom(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              // childAspectRatio: .8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: 4,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              height: (AppSize.s100 * 2.1).h,
              width: (AppSize.s100 * 1.6).w,
              decoration: BoxDecoration(
                  color: ColorManager.grey,
                  borderRadius: BorderRadius.circular(AppSize.s20.r)),
            );
          }),
    );
  }
}
