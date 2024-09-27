import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/widgets/svg_pic/svg_pic.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String serviceName;
  final String review;
  final String date;
  final String rate;
  const ReviewCard(
      {required this.name,
      required this.serviceName,
      required this.rate,
      required this.review,
      required this.date,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: context.width / 1.1,
      // height: AppSize.s100,
      padding: EdgeInsets.all(AppPadding.p10),
      margin: EdgeInsets.only(bottom: AppPadding.p10),
      height: (AppSize.s100 * 1.46).h,
      decoration: ShapeDecoration(
        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.30, color: Color(0x3380797E)),
          borderRadius: BorderRadius.circular(AppSize.s20.r),
        ),
        shadows: const [
          BoxShadow(
            color: ColorManager.white1,
            blurRadius: AppSize.s14,
            offset: Offset(AppSize.s0, AppSize.s4),
            spreadRadius: AppSize.s0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p6, vertical: AppPadding.p4),
                height: AppSize.s20.h,
                // width: AppSize.s48.w,
                decoration: ShapeDecoration(
                  color: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s50.r),
                  ),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPictureCustom(
                      assetsName: IconAssets.star2,
                      color: null,
                      height: AppSize.s14.h,
                      width: AppSize.s14.w,
                    ),
                    TextCustom(
                      textStyle: getRegularGilroyStyle(
                          color: ColorManager.white, fontSize: FontSize.s12),
                      text: rate,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: AppSize.s4.w,
              ),
              TextCustom(
                text: '@$name',
                textStyle: getRegularGilroyStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s12,
                ),
              ),
              const Spacer(),
              TextCustom(
                text: date,
                textStyle: getRegularGilroyStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          TextCustom(
            text: serviceName,
            textStyle: getSemiBoldGilroyStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s16,
                height: 0.07),
          ),
          SizedBox(
            height: AppSize.s12.h,
          ),
          SizedBox(
              width: (AppSize.s100 * 3.12).w,
              // height: AppSize.s56.h,
              child: TextCustom(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text: review,
                textStyle: getMediumGilroyStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s12,
                    height: 1.4),
              )),
        ],
      ),
    );
  }
}
