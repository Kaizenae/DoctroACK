import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LockRoleWidget extends StatelessWidget {
  final String? title;
  final double? height;
  final bool? back;
  const LockRoleWidget(
      {this.height = AppSize.s100,
      this.title = "You are not allowed Please Contact your Admin",
      this.back = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPictureCustom(
            assetsName: IconAssets.lockRoleIcon,
            color: null,
            height: (AppSize.s100 * 2).h,
            width: (AppSize.s100 * 2).w,
          ),
          const SizedBox(
            height: AppSize.s40,
          ),
          SizedBox(
            width: (AppSize.s100 * 2).w,
            child: TextCustom(
              text: title!,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              textStyle: getSemiBoldGilroyStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Visibility(
            visible: back!,
            child: ElevatedButtonCustom(
              width: AppSize.s100 * 2,
              text: "Back",
              colors: ColorManager.white,
              textColor: ColorManager.black,
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
