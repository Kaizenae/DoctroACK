import 'package:doctor_ack/core/api/end_points.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/add_remove_favourite_cubit/add_remove_favourite_state.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/add_remove_favourite_cubit/add_removefavourites_cubit.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/constants_manager.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../../modules/service/presentation/controller/service_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class FavServiceCardWidget extends StatelessWidget {
  final int index;

  final String? imageUrl;
  final String? name;
  final String? rate;
  final String? city;
  final int? id;

  const FavServiceCardWidget({
    required this.index,
    this.id = 0,
    this.imageUrl = '',
    this.name = 'Hydra Facial',
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
                      child: CachedNetworkImageCustom(
                          height: (AppSize.s100 * 1).h,
                          width: AppSize.s100.w,
                          boxFit: BoxFit.cover,
                          boarder: AppSize.s0,
                          url: imageUrl!),
                    ),
                  ),
                  Positioned(
                    top: AppSize.s10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                      child: SizedBox(
                        width: (AppSize.s100 * 1.4).w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p6,
                                  vertical: AppPadding.p2),
                              height: AppSize.s20.h,
                              width: AppSize.s50.w,
                              decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s30.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                            BlocConsumer<AddRemoveFavouritesCubit,
                                AddRemoveFavouritesState>(
                              listener: (context, state) {
                                if (state is AddRemoveFavouriteSuccessState) {
                                  FavouritesCubit.get(context).getFavourite();
                                  showToast(context,
                                      message:
                                          LocaleKeys.toastRemoveFavourite.tr(),
                                      type: MessageType.success);
                                } else if (state
                                    is AddRemoveFavouriteErrorState) {
                                  showToast(context,
                                      message: state.message,
                                      type: MessageType.error);
                                }
                              },
                              builder: (context, state) {
                                var removeFavCubit =
                                    AddRemoveFavouritesCubit.get(context);
                                return InkWell(
                                  onTap: () {
                                    removeFavCubit.id = id!;
                                    removeFavCubit.isClinic = false;
                                    removeFavCubit.endpoint =
                                        EndPoints.removeFavouriteEndpoint;
                                    removeFavCubit.addRemoveFavourite();
                                  },
                                  child: Container(
                                    width: AppSize.s24,
                                    height: AppSize.s24,
                                    padding: EdgeInsets.all(AppPadding.p4),
                                    decoration: const ShapeDecoration(
                                      color: Color(0xFFC1E9E9),
                                      shape: OvalBorder(),
                                    ),
                                    child: const SvgPictureCustom(
                                      assetsName: IconAssets.favorite,
                                      color: ColorManager.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: AppSize.s10,
                  //   right: AppSize.s8,
                  //   child: IconButtonCustom(
                  //       iconName: IconAssets.favorite,
                  //       color: ColorManager.red,
                  //       iconSize: AppSize.s20,
                  //       radius: AppSize.s30,
                  //       btnColor: const Color(0xFFC1E9E9),
                  //       onPressed: () {}),
                  //   // Container(
                  //   //   width: AppSize.s22,
                  //   //   height: AppSize.s22,
                  //   //   decoration: const ShapeDecoration(
                  //   //     color: Color(0xFFC1E9E9),
                  //   //     shape: OvalBorder(),
                  //   //   ),
                  //   //   child: SvgPictureCustom(assetsName: IconAssets.favouriteCircle),
                  //   // ),
                  // ),
                  // Positioned(
                  //   top: AppSize.s16,
                  //   left: AppSize.s10,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: AppPadding.p6, vertical: AppPadding.p2),
                  //     height: AppSize.s20.h,
                  //     width: AppSize.s50.w,
                  //     decoration: BoxDecoration(
                  //         color: ColorManager.primary,
                  //         borderRadius: BorderRadius.circular(AppSize.s30.r)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         SvgPictureCustom(
                  //           assetsName: IconAssets.star2,
                  //           color: null,
                  //           height: AppSize.s16.h,
                  //           width: AppSize.s16.w,
                  //         ),
                  //         TextCustom(
                  //           textStyle: TextStyle(
                  //             fontFamily: 'Gilroy',
                  //             fontSize: FontSize.s12,
                  //             color: ColorManager.white,
                  //             fontWeight: FontWeightManager.regular,
                  //           ),
                  //           text: rate!,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                    Column(
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
                            text: name!,
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
                            TextCustom(
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
                          ],
                        )
                      ],
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
