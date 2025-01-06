import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../modules/service/presentation/controller/service_cubit.dart';
import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/values_manager.dart';
import '../cached_image/cached_network_image.dart';
import '../svg_pic/svg_pic.dart';
import '../text_custom/text_custom.dart';

class ServiceCardWidget extends StatelessWidget {
  final int index;
  final int length;
  final bool? network;

  final String? imageUrl;
  final String? name;
  final String? clinicName;
  final String? rate;
  final String? city;
  final int? id;

  const ServiceCardWidget({
    required this.index,
    this.id = 0,
    this.length = 8,
    this.network = false,
    this.imageUrl = '',
    this.name = 'Hydra Facial',
    this.clinicName = 'Skin & Hair Clinic',
    this.rate = '4.5',
    this.city = 'Dubai',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (AppSize.s100 * 2.1).h,
      width: (AppSize.s100 * 1.6).w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s20.r)),
      child: InkWell(
        onTap: () {
          ServiceCubit.get(context).serviceID = id!;
          ServiceCubit.get(context).doctorID = 0;
          navigator(context, Routes.serviceClinicRoute);
        },
        child: Stack(
          children: [
            Container(
              height: (AppSize.s100 * 1.75).h,
              width: (AppSize.s100 * 1.6).w,
              decoration: BoxDecoration(
                  color:
                      index % 2 == 0 ? ColorManager.pink : ColorManager.yellowL,
                  borderRadius: BorderRadius.circular(AppSize.s20.r)),
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPictureCustom(
                        assetsName: IconAssets.circle,
                        color: null,
                        height: AppSize.s80,
                        width: AppSize.s80,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPictureCustom(
                        assetsName: index % 2 == 0
                            ? IconAssets.lineB
                            : IconAssets.lineT,
                        color: null,
                        height: AppSize.s80,
                        width: AppSize.s80,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s20.r),
                          bottomRight: Radius.circular(AppSize.s20.r)),
                      child: network!
                          ? CachedNetworkImageCustom(
                              height: (AppSize.s100 * 1).h,
                              width: AppSize.s100.w,
                              boxFit: BoxFit.cover,
                              boarder: AppSize.s0,
                              url: imageUrl!)
                          : CachedNetworkImageCustom(
                              height: (AppSize.s100 * 1).h,
                              width: AppSize.s100.w,
                              boxFit: BoxFit.cover,
                              boarder: AppSize.s0,
                              url: ImageNetwork.serviceItems[index]),
                    ),
                  ),
                  Positioned(
                    top: AppSize.s14,
                    // right: AppConstants.language ? AppSize.s0 : AppSize.s8,
                    // left:AppConstants.language?AppSize.s8: AppSize.s0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p6, vertical: AppPadding.p2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: AppSize.s90,
                            child: TextCustom(
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              textStyle: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.regular,
                              ),
                              text: name!,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.p6,
                            ),
                            alignment: Alignment.center,
                            height: AppSize.s20.h,
                            width: AppSize.s50.w,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s30.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPictureCustom(
                                  assetsName: IconAssets.star2,
                                  color: null,
                                  height: AppSize.s16.h,
                                  width: AppSize.s16.w,
                                ),
                                TextCustom(
                                  textStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: FontSize.s12,
                                    color: ColorManager.white,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                  text: rate!,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              // bottom:-10,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(AppPadding.p6),
                width: (AppSize.s100 * 1.35).w,
                height: AppSize.s56.h,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: AppSize.s18.r,
                        backgroundColor: index % 2 == 0
                            ? ColorManager.pink
                            : ColorManager.yellowL,
                        child: const SvgPictureCustom(
                          assetsName: IconAssets.service1,
                          color: ColorManager.serviceIconColor,
                        )),
                    SizedBox(
                      width: AppSize.s4.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppSize.s80.w,
                            child: TextCustom(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textStyle: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.medium,
                              ),
                              text: clinicName!,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPictureCustom(
                                height: AppSize.s14.h,
                                width: AppSize.s14.w,
                                assetsName: IconAssets.locationIcon,
                                color: ColorManager.grey,
                              ),
                              SizedBox(
                                width: AppSize.s8.w,
                              ),
                              Expanded(
                                child: TextCustom(
                                  text: city!,
                                  textStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: FontSize.s12,
                                    color: ColorManager.grey,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
