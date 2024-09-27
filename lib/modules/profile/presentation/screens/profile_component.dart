import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class ProfileComponent extends StatelessWidget {
  final String iconName;
  final String name;
  final String screen;
  final Function? onTap;

  const ProfileComponent(
      {super.key,
      required this.name,
      required this.iconName,
      this.onTap,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p12),
      margin: EdgeInsets.only(bottom: AppPadding.p10),
      decoration: ShapeDecoration(
        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19C29E8A),
            blurRadius: AppSize.s20,
            offset: Offset(AppSize.s0, AppSize.s4),
            spreadRadius: 1,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          onTap != null ? onTap!() : navigator(context, screen);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p6.h),
          child: Row(
            children: [
              SvgPictureCustom(
                assetsName: iconName,
                color: ColorManager.primary,
                height: AppSize.s24.h,
                width: AppSize.s24.w,
              ),
              SizedBox(
                width: AppSize.s16.w,
              ),
              TextCustom(
                text: name,
                textStyle: getMediumGilroyStyle(
                  fontSize: FontSize.s16.sp,
                  color: ColorManager.black,
                ),
              ),
              const Spacer(),
              SvgPictureCustom(
                assetsName: AppConstants.language
                    ? IconAssets.arrowLeftC
                    : IconAssets.arrowRightC,
                color: ColorManager.primary,
                height: AppSize.s16.h,
                width: AppSize.s16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
