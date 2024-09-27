import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final double? height;
  const EmptyWidget(
      {this.height = AppSize.s100, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPictureCustom(
          assetsName: IconAssets.emptyFavourites,
          color: null,
          height: (AppSize.s100 * 2.8).h,
          width: (AppSize.s100 * 2.8).w,
        ),
        TextCustom(
          text: title.tr(),
          textStyle: getSemiBoldGilroyStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
