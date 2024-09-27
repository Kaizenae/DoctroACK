import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RSizedBox.vertical(AppSize.s30),
              Center(
                child: Image.asset(
                  ImageAssets.logo1,
                  height: AppSize.s70.h,
                  width: AppSize.s100.w * 1.65,
                ),
              ),
              const RSizedBox.vertical(AppSize.s44),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPictureCustom(
                      assetsName: IconAssets.rectangleDone,
                      color: null,
                      height: AppSize.s100.h * 2.1,
                      width: AppSize.s100.w * 2.9),
                  Image.asset(ImageAssets.done,
                      height: AppSize.s100.h, width: AppSize.s100.w),
                ],
              ),
              const SizedBox(
                height: AppSize.s22,
              ),
              TextCustom(
                text: LocaleKeys.successfullyDone,
                fontSize: FontSize.s22,
                fontWeight: FontWeightManager.medium,
              ),
              const SizedBox(
                height: AppSize.s6,
              ),
              TextCustom(
                text: LocaleKeys.passwordResetSuccessfully,
                textStyle: getMediumGilroyStyle(
                    color: ColorManager.grey, fontSize: FontSize.s12),
              ),
              const SizedBox(
                height: AppSize.s24,
              ),
              ElevatedButtonCustom(
                text: LocaleKeys.loginNow,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  navigatorAndRemove(context, Routes.loginRoute);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
