import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/routes_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ClinicCard extends StatelessWidget {
  final int? id;
  final String? name;
  final String? icon;
  final String? expertise;
  final String? experience;
  final String? phone;
  final String? patient;
  final String? rate;
  const ClinicCard({
    this.id = 0,
    this.expertise = '0',
    this.phone = '',
    this.name = '',
    this.icon = '',
    this.experience = '',
    this.patient = '0',
    this.rate = '0.0',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 197,
      left: context.tablet ? AppSize.s100 * 2.3 : AppSize.s18.w,
      child: Container(
        width: (AppSize.s100 * 3.43).w,
        height: (AppSize.s100 * 1.3).h,
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p10, vertical: AppPadding.p12),
        decoration: ShapeDecoration(
          color: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1C777373),
              blurRadius: AppSize.s14,
              offset: Offset(AppSize.s0, AppSize.s14),
              spreadRadius: AppSize.s0,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppSize.s28.h,
                  height: AppSize.s28.h,
                  padding: EdgeInsets.all(AppPadding.p6),
                  decoration: ShapeDecoration(
                    color: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: SvgPictureCustom(
                    assetsName: IconAssets.service1,
                    color: null,
                    height: AppSize.s14.h,
                    width: AppSize.s14.h,
                  ),
                ),
                SizedBox(
                  width: AppSize.s8.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: name!,
                      fontSize: FontSize.s22,
                      fontWeight: FontWeightManager.regular,
                    ),
                    SizedBox(
                      height: AppSize.s4.h,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(AppPadding.p8),
                  width: AppSize.s80.w,
                  height: AppSize.s40.h,
                  decoration: ShapeDecoration(
                    color: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: AppSize.s14,
                        offset: Offset(AppSize.s0, AppSize.s4),
                        spreadRadius: AppSize.s0,
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      ReviewsCubit.get(context).isClinic = true;
                      ReviewsCubit.get(context).clinicID = id!;
                      ReviewsCubit.get(context).clinicRate = rate!;
                      ReviewsCubit.get(context).clinicName = name!;
                      navigator(context, Routes.clinicReviewsRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPictureCustom(
                          assetsName: IconAssets.star2,
                          color: null,
                          height: AppSize.s24.h,
                          width: AppSize.s24.w,
                        ),
                        TextCustom(
                          textStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: FontSize.s20,
                            color: ColorManager.white,
                            fontWeight: FontWeightManager.regular,
                          ),
                          text: rate!,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSize.s10.h,
            ),
            InkWell(
              onTap: () async {
                await launchInBrowser(Uri.parse("tel:$phone"));
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppPadding.p8),
                    width: AppSize.s40.h,
                    height: AppSize.s40.h,
                    decoration: const ShapeDecoration(
                      color: ColorManager.yellowL1,
                      shape: OvalBorder(),
                    ),
                    child: const SvgPictureCustom(assetsName: IconAssets.phone),
                  ),
                  SizedBox(
                    width: AppSize.s8.w,
                  ),
                  TextCustom(
                    text: phone!,
                    textStyle: TextStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s14,
                      fontFamily: 'Gilroy-Medium',
                      fontWeight: FontWeightManager.regular,
                      height: 0,
                      letterSpacing: -0.28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
