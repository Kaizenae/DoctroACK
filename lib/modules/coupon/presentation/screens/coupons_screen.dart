import 'dart:math' as math;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: LocaleKeys.coupons,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              Container(
                width: context.width,
                height: AppSize.s100,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(AppSize.s10),
                        ),
                        child: SvgPicture.asset('assets/icons/Ellipse 53.svg'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(AppSize.s10),
                        ),
                        child: SvgPicture.asset('assets/icons/Ellipse 57.svg'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.s10),
                        ),
                        child: SvgPicture.asset('assets/icons/Ellipse 54.svg'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s10),
                        ),
                        child: SvgPicture.asset('assets/icons/Ellipse 56.svg'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCustom(
                            text: '500',
                            fontSize: FontSize.s40,
                            color: ColorManager.white,
                          ),
                          TextCustom(
                            text: LocaleKeys.totalPoints,
                            fontSize: FontSize.s12,
                            color: ColorManager.pointColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s50),
              Container(
                height: AppSize.s100,
                padding: EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  color: ColorManager.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100]!,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const SvgPictureCustom(
                          height: AppSize.s60,
                          width: AppSize.s60,
                          color: ColorManager.primary,
                          assetsName: IconAssets.star2,
                        ),
                        Transform.rotate(
                          angle: -math.pi / AppSize.s12,
                          child: TextCustom(
                            text: '10%',
                            color: ColorManager.white,
                            fontSize: FontSize.s22,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p10),
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: TextCustom(
                                text: LocaleKeys.couponBody,
                                color: ColorManager.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s18,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButtonCustom(
                                colors: ColorManager.white,
                                textColor: ColorManager.primary,
                                fontSize: FontSize.s16,
                                width: AppSize.s60,
                                height: AppSize.s30,
                                radius: AppSize.s8,
                                text: '250',
                                onPressed: () async {
                                  await dialog(context: context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future dialog(
      {required BuildContext context,
      String? title,
      String? body,
      String? code}) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      title: title,
      width: double.infinity,
      desc: '',
      showCloseIcon: true,
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextCustom(
              text: LocaleKeys.congrats,
              fontSize: FontSize.s22,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: AppSize.s24,
            ),
            TextCustom(
              textAlign: TextAlign.center,
              text: LocaleKeys.couponMsg,
              fontSize: FontSize.s16,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
            const SizedBox(
              height: AppSize.s24,
            ),
            TextCustom(
              arabic: false,
              text: LocaleKeys.couponCode,
              fontSize: FontSize.s40,
              fontWeight: FontWeight.w600,
              color: ColorManager.black,
            ),
          ],
        ),
      ),
    ).show();
  }
}
