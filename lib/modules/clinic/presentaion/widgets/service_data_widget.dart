import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/rating_bar/rating_bar.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';

import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import '../../../service/presentation/controller/service_cubit.dart';
import '../../../service/presentation/controller/service_state.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ServiceDataWidget extends StatelessWidget {
  const ServiceDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ServiceCubit>(context)..getService(),
      child: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          var serviceCubit = ServiceCubit.get(context);
          return switch (state) {
            GetServiceSuccessState() => Column(
                children: [
                  SizedBox(
                    width: (AppSize.s100 * 1.4).w,
                    child: Stack(
                      children: [
                        Container(
                          height: (AppSize.s100).h,
                          width: (AppSize.s100).h,
                          decoration: ShapeDecoration(
                            color: ColorManager.rose,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(56.25),
                            ),
                          ),
                          child: Stack(
                            children: [
                              const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SvgPictureCustom(
                                    assetsName: IconAssets.circle,
                                    color: ColorManager.rose1,
                                    height: AppSize.s56,
                                    width: AppSize.s56,
                                  )),
                              const Align(
                                  alignment: Alignment.center,
                                  child: SvgPictureCustom(
                                    assetsName: IconAssets.lineT,
                                    color: null,
                                    height: AppSize.s80,
                                    width: AppSize.s80,
                                  )),
                              Positioned(
                                bottom: 3,
                                right: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(AppSize.s30.r)),
                                  child: CachedNetworkImageCustom(
                                    url: state.serviceEntity.resultEntity
                                        .response.icon,
                                    width: AppSize.s70.w,
                                    height: AppSize.s80.h,
                                    boxFit: BoxFit.fill,
                                    boarder: AppSize.s0,
                                  ),
                                  // CachedNetworkImageCustom(
                                  //     width: AppSize.s70.w,
                                  //     height: AppSize.s80.h,
                                  //     boxFit: BoxFit.fill,
                                  //     boarder: AppSize.s0,
                                  //     url: ImageNetwork.filerImage),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.serviceEntity.resultEntity.response
                                  .discount !=
                              0.0,
                          child: Positioned(
                            top: AppSize.s0,
                            right: AppSize.s2,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPictureCustom(
                                  assetsName: IconAssets.rectangleDisc,
                                  color: null,
                                  height: AppSize.s28.h,
                                  width: AppSize.s60.w,
                                ),
                                Positioned(
                                  top: AppSize.s4,
                                  child: TextCustom(
                                    text:
                                        '${state.serviceEntity.resultEntity.response.discount}% ${LocaleKeys.off.tr()}',
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.s12,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.serviceEntity.resultEntity.response.discount != 0
                          ? TextCustom(
                              text:
                                  '${LocaleKeys.aED.tr()}${state.serviceEntity.resultEntity.response.priceWithoutDiscount.toStringAsFixed(0)}',
                              textAlign: TextAlign.start,
                              decoration: TextDecoration.lineThrough,
                              textStyle: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: ColorManager.primary,
                                fontSize: FontSize.s18,
                                fontFamily: 'Gilroy-SemiBold',
                                fontWeight: FontWeightManager.semiBold,
                                // height: 0.05,
                              ),
                            )
                          : const SizedBox(),
                      state.serviceEntity.resultEntity.response.discount != 0.0
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(),
                      // Visibility(
                      //   visible: state
                      //           .serviceEntity.resultEntity.response.discount !=
                      //       0.0,
                      //   child: Positioned(
                      //     top: AppSize.s0,
                      //     right: AppSize.s2,
                      //     child: Stack(
                      //       alignment: Alignment.center,
                      //       children: [
                      //         SvgPictureCustom(
                      //           assetsName: IconAssets.rectangleDisc,
                      //           color: null,
                      //           height: AppSize.s28.h,
                      //           width: AppSize.s60.w,
                      //         ),
                      //         Positioned(
                      //           top: AppSize.s4,
                      //           child: TextCustom(
                      //             text:
                      //                 '${state.serviceEntity.resultEntity.response.discount}% ${LocaleKeys.off.tr()}',
                      //             textStyle: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: FontSize.s12,
                      //               fontFamily: 'SF Pro Text',
                      //               fontWeight: FontWeight.w600,
                      //               height: 0,
                      //               letterSpacing: -0.24,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      state.serviceEntity.resultEntity.response.discount != 0.0
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(),
                      TextCustom(
                        text:
                            '${LocaleKeys.aED.tr()}${state.serviceEntity.resultEntity.response.priceWithDiscount.toStringAsFixed(0)}',
                        textAlign: TextAlign.start,
                        decoration: TextDecoration.lineThrough,
                        textStyle: TextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s18,
                          fontFamily: 'Gilroy-SemiBold',
                          fontWeight: FontWeightManager.semiBold,
                          // height: 0.05,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  InkWell(
                    onTap: () {
                      ReviewsCubit.get(context).isClinic = false;
                      ReviewsCubit.get(context).clinicID =
                          state.serviceEntity.resultEntity.response.id;
                      ReviewsCubit.get(context).clinicRate = state
                          .serviceEntity.resultEntity.response.rate
                          .toStringAsFixed(1);
                      ReviewsCubit.get(context).clinicName =
                          state.serviceEntity.resultEntity.response.name;
                      navigator(context, Routes.clinicReviewsRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarCustom(
                          itemCount: 1,
                          averageRating: state
                              .serviceEntity.resultEntity.response.rate
                              .toStringAsFixed(2),
                          itemSize: AppSize.s20.sp,
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.black,
                        ),
                        TextCustom(
                          text:
                              ' (${state.serviceEntity.resultEntity.response.reviews} ${LocaleKeys.review.tr()})',
                          textStyle: TextStyle(
                            color: ColorManager.grey1,
                            fontSize: FontSize.s16,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.32,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  ReadMoreText(
                    state.serviceEntity.resultEntity.response.description,
                    trimLines: 3,
                    trimLength: 325,
                    textAlign: TextAlign.center,
                    style: getRegularGilroyStyle(
                      color: ColorManager.grey,
                      fontSize: FontSize.s12,
                    ),
                    colorClickableText: ColorManager.primary,
                    trimMode: TrimMode.Line,
                    moreStyle: getSemiBoldGilroyStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s12,
                    ),
                    lessStyle: getRegularGilroyStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s12,
                    ),
                    trimCollapsedText: LocaleKeys.readMore.tr(),
                    trimExpandedText: LocaleKeys.collapse.tr(),
                  )
                ],
              ),
            GetServiceErrorState() => ErrorsWidget(
                onPress: () => serviceCubit.getService(), text: state.message),
            GetServiceLoadingState() => ShimmerCustom(
                  child: Column(
                children: [
                  SizedBox(
                    width: (AppSize.s100 * 1.4).w,
                    child: Container(
                      height: (AppSize.s100).h,
                      width: (AppSize.s100).h,
                      decoration: ShapeDecoration(
                        color: ColorManager.rose,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56.25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  TextCustom(
                    text: '0 AED',
                    textAlign: TextAlign.start,
                    textStyle: getSemiBoldGilroyStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s20,

                      // height: 0.05,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBarCustom(
                        itemCount: 1,
                        averageRating: '0.0',
                        itemSize: AppSize.s20.sp,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.black,
                      ),
                      TextCustom(
                        text: ' (000 ${LocaleKeys.review.tr()})',
                        textStyle: TextStyle(
                          color: ColorManager.grey1,
                          fontSize: FontSize.s16,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.32,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  ShimmerCustom(
                      child: Container(
                    height: AppSize.s60,
                    color: ColorManager.grey,
                  )),
                ],
              )),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
