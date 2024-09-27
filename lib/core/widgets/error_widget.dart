import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/assets_manager.dart';
import '../utils/color_manager.dart';
import '../utils/font_manager.dart';
import '../utils/styles_manager.dart';
import '../utils/values_manager.dart';
import 'elevated_button/elevated_button_custom.dart';
import 'svg_pic/svg_pic.dart';
import 'text_custom/text_custom.dart';

class ErrorsWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;

  const ErrorsWidget({super.key, this.onPress, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPictureCustom(
            assetsName: IconAssets.errorIcon,
            color: null,
            height: (AppSize.s100 * 2.8).h,
            width: (AppSize.s100 * 2.8).w,
          ),
          const RSizedBox.vertical(AppSize.s6),
          TextCustom(
            text: 'Opps!! Error occurred!',
            textStyle: getRegularStyle(
                color: ColorManager.primary, fontSize: FontSize.s22),
          ),
          TextCustom(
            text: text!,
            textStyle: getRegularGilroyStyle(
              color: ColorManager.divider,
            ),
          ),
          Container(
            height: AppSize.s50,
            width: context.width * 0.55,
            margin: EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: ElevatedButtonCustom(
              text: 'Try again',
              onPressed: () {
                if (onPress != null) {
                  onPress!();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class HErrorsWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;

  const HErrorsWidget({super.key, this.onPress, this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPictureCustom(
            assetsName: IconAssets.errorIcon,
            color: null,
            height: (AppSize.s100 * 1.5).h,
            width: (AppSize.s100).w,
          ),
          const RSizedBox.horizontal(AppSize.s6),
          Column(
            children: [
              TextCustom(
                text: 'Opps!! Error occurred!',
                textStyle: getRegularStyle(
                    color: ColorManager.primary, fontSize: FontSize.s18),
              ),
              TextCustom(
                text: 'Opps!! Error occurred!',
                textStyle: getRegularGilroyStyle(
                  color: ColorManager.divider,
                ),
              ),
              Container(
                height: AppSize.s30,
                width: context.width * 0.4,
                margin: EdgeInsets.symmetric(vertical: AppPadding.p14),
                child: ElevatedButtonCustom(
                  fontSize: FontSize.s16,
                  text: 'Try again',
                  onPressed: () {
                    if (onPress != null) {
                      onPress!();
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
