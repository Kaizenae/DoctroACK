import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/clinic_cubit/clinic_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/routes_manager.dart';
import '../../utils/values_manager.dart';
import '../cached_image/cached_network_image.dart';
import '../component.dart';
import '../svg_pic/svg_pic.dart';
import '../text_custom/text_custom.dart';

class ClinicCardWidget extends StatelessWidget {
  final int index;
  final int id;
  final int? length;
  final String? imageUrl;
  final String? name;
  final String? description;
  final String? city;
  final String? rate;
  final bool? network;
  final bool? favourite;

  const ClinicCardWidget({
    required this.index,
    this.id = 0,
    this.length = 8,
    this.network = false,
    this.favourite = false,
    this.imageUrl = ImageNetwork.profile1Image,
    this.name = 'Maris Clinic',
    this.city = 'USA',
    this.rate = '4.5',
    this.description =
        'This clinic improve skin\'s health and This clinic improve skin\'s health and',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p8, horizontal: AppPadding.p10),
      // margin: EdgeInsets.only(right: AppPadding.p20),
      // height: (AppSize.s100 * 1.73).h,
      width: context.tablet ? (AppSize.s100 * 1.61).w : context.width / 2.4,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? ColorManager.primary : ColorManager.secondary,
        borderRadius: BorderRadius.circular(AppSize.s20.r),
      ),
      child: InkWell(
        onTap: () {
          ClinicCubit.get(context).clinicID = id;
          navigator(context, Routes.clinicRoute);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            network!
                ? CachedNetworkImageCustom(
                    url: imageUrl!,
                    boarder: AppSize.s30.r,
                    height: AppSize.s60.h,
                    width: AppSize.s60.h,
                    boxFit: BoxFit.fill)
                : CachedNetworkImageCustom(
                    boarder: AppSize.s30.r,
                    height: AppSize.s60.h,
                    width: AppSize.s60.h,
                    url: imageUrl!,
                    boxFit: BoxFit.fill),
            const SizedBox(
              height: AppSize.s6,
            ),
            TextCustom(
              text: name!,
              fontSize: FontSize.s16,
              color: ColorManager.white,
            ),
            const SizedBox(
              height: AppSize.s6,
            ),
            SizedBox(
              width: (AppSize.s100 * 1.4).w,
              height: AppSize.s20.h,
              child: TextCustom(
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: description!,
                textStyle: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: FontSize.s12,
                  color: ColorManager.white,
                  fontWeight: FontWeightManager.light,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SvgPictureCustom(
                        assetsName: IconAssets.locationIcon,
                        color: ColorManager.white,
                      ),
                      SizedBox(
                        width: AppSize.s4.w,
                      ),
                      Expanded(
                        child: TextCustom(
                          text: city!,
                          textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Gilroy',
                            fontSize: FontSize.s12,
                            color: ColorManager.white,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SvgPictureCustom(
                      assetsName: IconAssets.star2,
                      color: null,
                    ),
                    SizedBox(
                      width: AppSize.s4.w,
                    ),
                    TextCustom(
                      text: rate!,
                      textStyle: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: FontSize.s12,
                        color: ColorManager.white,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
