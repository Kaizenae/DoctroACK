import 'package:doctor_ack/core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/controllers/clinic_profile_cubit/clinic_profile_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../../modules/clinic/presentaion/widgets/clinic_card.dart';

class VendorAboutUs extends StatelessWidget {
  const VendorAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        body: SmartRefresher(
      controller: VendorClinicCubit.get(context).refreshAboutController,
      onRefresh: () => VendorClinicCubit.get(context).getClinicProfile(),
      child: SingleChildScrollView(
        child: BlocBuilder<VendorClinicCubit, ClinicProfileState>(
          builder: (context, state) {
            var clinicCubit = VendorClinicCubit.get(context);
            return switch (state) {
              ClinicProfileSuccessState() => Stack(
                  children: [
                    Column(
                      children: [
                        CachedNetworkImageCustom(
                          url: state
                              .clinicProfileEntity.resultEntity.response.icon,
                          // width: AppSize.s100,
                          height: (AppSize.s100 * 2.5).h,
                          // boarder: AppSize.s24.r,
                        ),
                        SizedBox(
                          height: (AppSize.s80 * 1.2).h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p20,
                              horizontal: AppPadding.p16),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: LocaleKeys.aboutTheClinic,
                                  textStyle: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s18,
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontWeight: FontWeightManager.semiBold,
                                    height: 0,
                                    letterSpacing: -0.36,
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s8.h,
                                ),
                                ReadMoreText(
                                  state.clinicProfileEntity.resultEntity
                                      .response.description,
                                  trimLines: 3,
                                  style: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12,
                                    fontFamily: 'Gilroy-Medium',
                                    fontWeight: FontWeight.w400,
                                    // height: 0.12,
                                    letterSpacing: -0.24,
                                  ),
                                  colorClickableText: ColorManager.primary,
                                  trimMode: TrimMode.Line,
                                  moreStyle: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s12,
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontWeight: FontWeight.w600,
                                    height: 0.12,
                                    letterSpacing: -0.24,
                                  ),
                                  lessStyle: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s12,
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontWeight: FontWeight.w600,
                                    height: 0.12,
                                    letterSpacing: -0.24,
                                  ),
                                  trimCollapsedText: LocaleKeys.readMore.tr(),
                                  trimExpandedText: LocaleKeys.collapse.tr(),
                                ),
                                SizedBox(
                                  height: AppSize.s20.h,
                                ),
                                Container(
                                  width: (AppSize.s100 * 3.43).w,
                                  // height: (AppSize.s100 * 1.1).h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppPadding.p20,
                                      horizontal: AppPadding.p14),
                                  decoration: ShapeDecoration(
                                    color: ColorManager.white1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                            text: LocaleKeys.address,
                                            textStyle: TextStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s18,
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                              height: 0,
                                              letterSpacing: -0.36,
                                            ),
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                          SizedBox(
                                            // height: AppSize.s60.h,
                                            width: (AppSize.s100 * 2.2).w,
                                            child: TextCustom(
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              text:
                                                  '${state.clinicProfileEntity.resultEntity.response.address.street}, ${state.clinicProfileEntity.resultEntity.response.address.city}, ${state.clinicProfileEntity.resultEntity.response.address.state}',
                                              textStyle: TextStyle(
                                                color: ColorManager.grey,
                                                fontSize: FontSize.s14,
                                                fontFamily: 'Gilroy-SemiBold',
                                                fontWeight:
                                                    FontWeightManager.medium,
                                              ),
                                              fontWeight:
                                                  FontWeightManager.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: AppSize.s70.w,
                                        height: AppSize.s80.h,
                                        decoration: ShapeDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                ImageAssets.mapAddress),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ClinicCard(
                      id: state.clinicProfileEntity.resultEntity.response.id,
                      name:
                          state.clinicProfileEntity.resultEntity.response.name,
                      rate: state.clinicProfileEntity.resultEntity.response.rate
                          .toStringAsFixed(1),
                      phone:
                          state.clinicProfileEntity.resultEntity.response.phone,
                      patient: state
                          .clinicProfileEntity.resultEntity.response.numPatient
                          .toString(),
                      icon:
                          state.clinicProfileEntity.resultEntity.response.icon,
                      expertise: state
                          .clinicProfileEntity.resultEntity.response.expertise,
                      experience: state.clinicProfileEntity.resultEntity
                          .response.numExperience
                          .toString(),
                    ),
                    Positioned(
                      top: AppSize.s70,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppPadding.p16),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPictureCustom(
                              assetsName: AppConstants.language
                                  ? IconAssets.arrowRight
                                  : IconAssets.arrowLeft,
                              color: ColorManager.white,
                            )),
                      ),
                    )
                  ],
                ),
              ClinicProfileErrorState() => ErrorsWidget(
                  onPress: () => clinicCubit.getClinicProfile(),
                ),
              ClinicProfileLoadingState() =>
                const ShimmerCustom(child: ShimmerClinic()),
              _ => const ShimmerCustom(child: ShimmerClinic()),
            };
          },
        ),
      ),
    ));
  }
}

class ShimmerClinic extends StatelessWidget {
  const ShimmerClinic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CachedNetworkImageCustom(
              url: ImageNetwork.specialOffer1Image,
              // width: AppSize.s100,
              height: (AppSize.s100 * 2.5).h,
              // boarder: AppSize.s24.r,
            ),
            SizedBox(
              height: (AppSize.s80 * 1.2).h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p20, horizontal: AppPadding.p16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: LocaleKeys.aboutTheClinic,
                      textStyle: TextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s18,
                        fontFamily: 'Gilroy-SemiBold',
                        fontWeight: FontWeightManager.semiBold,
                        height: 0,
                        letterSpacing: -0.36,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s8.h,
                    ),
                    ReadMoreText(
                      'A skin clinic is a specialized healthcare facility dedicated to the diagnosis, treatment of skin-related conditions & cosmetic concerns. These clinics are staffed with, A skin clinic is a specialized healthcare facility dedicated to the diagnosis, treatment of skin-related conditions & cosmetic concerns. These clinics are staffed with',
                      trimLines: 3,
                      style: TextStyle(
                        color: ColorManager.grey,
                        fontSize: FontSize.s12,
                        fontFamily: 'Gilroy-Medium',
                        fontWeight: FontWeight.w400,
                        // height: 0.12,
                        letterSpacing: -0.24,
                      ),
                      colorClickableText: ColorManager.primary,
                      trimMode: TrimMode.Line,
                      moreStyle: TextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s12,
                        fontFamily: 'Gilroy-SemiBold',
                        fontWeight: FontWeight.w600,
                        height: 0.12,
                        letterSpacing: -0.24,
                      ),
                      lessStyle: TextStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s12,
                        fontFamily: 'Gilroy-SemiBold',
                        fontWeight: FontWeight.w600,
                        height: 0.12,
                        letterSpacing: -0.24,
                      ),
                      trimCollapsedText: LocaleKeys.readMore.tr(),
                      trimExpandedText: LocaleKeys.collapse.tr(),
                    ),
                    SizedBox(
                      height: AppSize.s20.h,
                    ),
                    Container(
                      width: (AppSize.s100 * 3.43).w,
                      height: (AppSize.s100 * 1.1).h,
                      padding: EdgeInsets.symmetric(
                          vertical: AppPadding.p20, horizontal: AppPadding.p14),
                      decoration: ShapeDecoration(
                        color: ColorManager.white1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s20.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: LocaleKeys.address,
                                textStyle: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s18,
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontWeight: FontWeightManager.semiBold,
                                  height: 0,
                                  letterSpacing: -0.36,
                                ),
                                fontWeight: FontWeightManager.bold,
                              ),
                              SizedBox(
                                height: AppSize.s40.h,
                                width: (AppSize.s100 * 2.2).w,
                                child: TextCustom(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text:
                                      'Robert Robertson, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678.',
                                  textStyle: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s14,
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: AppSize.s70.w,
                            height: AppSize.s80.h,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage(ImageAssets.mapAddress),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const ClinicCard(),
        Positioned(
          top: AppSize.s70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SvgPictureCustom(
                  assetsName: IconAssets.arrowLeft,
                  color: ColorManager.white,
                )),
          ),
        )
      ],
    );
  }
}
