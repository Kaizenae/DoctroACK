// ignore_for_file: use_build_context_synchronously

import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/clinic_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../modules/language/presentation/pages/lang_view.dart';
import '../../../../modules/profile/presentation/screens/profile_component.dart';
import '../../../../modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import '../../../../modules/webViews/controllers/web_view_cubit.dart';
import '../controllers/clinic_profile_cubit/clinic_profile_cubit.dart';

class ClinicBody extends StatelessWidget {
  const ClinicBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        controller: VendorClinicCubit.get(context).refreshController,
        onRefresh: () => VendorClinicCubit.get(context).getClinicProfile(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<VendorClinicCubit>(context)
                  ..getClinicProfile(),
                child: BlocConsumer<VendorClinicCubit, ClinicProfileState>(
                  listener: (context, state) {
                    if (state is ClinicProfileSuccessState) {
                      AllServicesCubit.get(context).clinicId =
                          state.clinicProfileEntity.resultEntity.response.id;
                    }
                  },
                  builder: (context, state) {
                    var clinicCubit = VendorClinicCubit.get(context);
                    return SizedBox(
                      height: AppSize.s100 * 3,
                      child: switch (state) {
                        ClinicProfileSuccessState() => Stack(
                            // alignment: Alignment.center,
                            children: [
                              Image.asset(
                                ImageAssets.profileRectangle,
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                                height: (AppSize.s100 * 1.79).h,
                              ),
                              Positioned(
                                top: AppSize.s30,
                                child: SizedBox(
                                  width: context.width,
                                  child: Padding(
                                    padding: EdgeInsets.all(AppPadding.p16),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: AppSize.s20.w,
                                        ),
                                        TextCustom(
                                          text: LocaleKeys.account,
                                          fontSize: FontSize.s18,
                                          color: ColorManager.white,
                                          fontWeight: FontWeightManager.medium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: (AppSize.s100 * 1.6).h,
                                right: context.tablet
                                    ? (AppSize.s100 * 2.3).w
                                    : AppSize.s16.w,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: AppPadding.p100 / 1.3),
                                  alignment: Alignment.center,
                                  // height: (AppSize.s100*2).h,
                                  width: (AppSize.s100 * 3.4).w,
                                  color: ColorManager.white,
                                  child: TextCustom(
                                    text: state.clinicProfileEntity.resultEntity
                                        .response.name,
                                    fontSize: FontSize.s22,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: (AppSize.s100).h,
                                right: context.tablet
                                    ? (AppSize.s100 * 3.4).w
                                    : (AppSize.s100 * 1.21).w,
                                child: Container(
                                  width: (AppSize.s100 * 1.32).h,
                                  height: (AppSize.s100 * 1.32).h,
                                  decoration: const ShapeDecoration(
                                    // color: ColorManager.black,
                                    shape: OvalBorder(
                                      side: BorderSide(
                                        width: 6,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child:
                                      // cubit.image.isEmpty ?
                                      CachedNetworkImageCustom(
                                    width: (AppSize.s100 * 1.32).h,
                                    height: (AppSize.s100 * 1.32).h,
                                    boarder: AppSize.s60,
                                    url: state.clinicProfileEntity.resultEntity
                                        .response.image,
                                  ),
                                  //     : CachedNetworkImageCustom(
                                  //   boarder: AppSize.s80,
                                  //   url: cubit.image,
                                  //   boxFit: BoxFit.fill,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ClinicProfileErrorState() => HErrorsWidget(
                            onPress: () => clinicCubit.getClinicProfile(),
                          ),
                        ClinicProfileLoadingState() => ShimmerCustom(
                              child: Container(
                            color: ColorManager.grey,
                          )),
                        _ => ShimmerCustom(
                              child: Container(
                            color: ColorManager.grey,
                          )),
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s20.h,
              ),
              const ClinicProfileWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClinicProfileWidget extends StatelessWidget {
  const ClinicProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: BlocBuilder<VendorClinicCubit, ClinicProfileState>(
          builder: (context, state) {
            var clinicCubit = VendorClinicCubit.get(context);
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: clinicCubit.iconName.length,
              itemBuilder: (context, index) => ProfileComponent(
                name: clinicCubit.name[index],
                iconName: clinicCubit.iconName[index],
                screen: clinicCubit.routeName[index],
                onTap: () {
                  if (index == 5) {
                    bottomSheetCustom(
                        height: AppSize.s100.h * 2.8,
                        context: context,
                        body: Material(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s30.r),
                              topRight: Radius.circular(AppSize.s30.r)),
                          child: const LanguageView(),
                        ));
                  } else if (index == 6) {
                    WebViewCubit.get(context).terms = false;
                    navigator(context, Routes.webViewRoute);
                  } else if (index == 7) {
                    WebViewCubit.get(context).terms = true;
                    navigator(context, Routes.webViewRoute);
                  } else if (index == 10) {
                    dialogCustom(
                        pressEventOk: () async {
                          AppConstants.token = '';
                          AppConstants.expireToken = '';
                          AppConstants.type = '';
                          await CacheHelper.removeData(
                            key: AppStrings.cachedRole,
                          );
                          await CacheHelper.removeData(
                            key: AppStrings.cachedID,
                          );
                          AppConstants.role = '';
                          AppConstants.cachedId = 0;
                          await CacheHelper.clearData().then((value) =>
                              navigatorAndRemove(context, Routes.loginRoute));
                        },
                        context: context,
                        okButtonName: LocaleKeys.logout.tr(),
                        cancelButtonName: LocaleKeys.cancel.tr(),
                        body: Column(
                          children: [
                            TextCustom(
                              text: '${LocaleKeys.logout.tr()}?',
                              fontWeight: FontWeightManager.semiBold,
                              fontSize: FontSize.s18,
                            ),
                            const RSizedBox.vertical(AppSize.s16),
                            TextCustom(
                              text: LocaleKeys.logoutWarning,
                              textStyle: getMediumGilroyStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            const RSizedBox.vertical(AppSize.s16),
                          ],
                        ));
                  } else if (index == 0 && state is ClinicProfileSuccessState) {
                    // EditClinicCubit.get(context).image = ImageNetwork.clinicLogo;
                    //  EditClinicCubit.get(context).imageCover = ImageNetwork.specialOffer1Image;
                    EditClinicCubit.get(context).image =
                        state.clinicProfileEntity.resultEntity.response.image;
                    EditClinicCubit.get(context).imageCover =
                        state.clinicProfileEntity.resultEntity.response.icon;
                    EditClinicCubit.get(context).nameController.text =
                        state.clinicProfileEntity.resultEntity.response.name;
                    EditClinicCubit.get(context).experienceController.text =
                        state.clinicProfileEntity.resultEntity.response
                            .numExperience
                            .toString();
                    EditClinicCubit.get(context).expertiseController.text =
                        state.clinicProfileEntity.resultEntity.response
                            .expertise;
                    EditClinicCubit.get(context).streetController.text = state
                        .clinicProfileEntity
                        .resultEntity
                        .response
                        .address
                        .street;
                    EditClinicCubit.get(context).cityController.text = state
                        .clinicProfileEntity.resultEntity.response.address.city;
                    EditClinicCubit.get(context).stateController.text = state
                        .clinicProfileEntity
                        .resultEntity
                        .response
                        .address
                        .state;
                    EditClinicCubit.get(context).phoneController.text =
                        state.clinicProfileEntity.resultEntity.response.phone;
                    EditClinicCubit.get(context).aboutController.text = state
                        .clinicProfileEntity.resultEntity.response.description;
                    navigator(context, Routes.editClinicRoute);
                  } else if (index == 1 && state is ClinicProfileSuccessState) {
                    ReviewsCubit.get(context).isClinic = true;

                    ReviewsCubit.get(context).clinicID =
                        state.clinicProfileEntity.resultEntity.response.id;
                    ReviewsCubit.get(context).clinicName =
                        state.clinicProfileEntity.resultEntity.response.name;
                    ReviewsCubit.get(context).clinicRate = state
                        .clinicProfileEntity.resultEntity.response.rate
                        .toStringAsFixed(1);

                    navigator(context, Routes.clinicReviewsRoute);
                  } else if (index == 11) {
                    dialogCustom(
                        pressEventOk: () async {
                          await UsersCubit.get(context).deleteUserAccountFun();
                          AppConstants.token = '';
                          AppConstants.expireToken = '';
                          AppConstants.type = '';
                          await CacheHelper.clearData().then((value) =>
                              navigatorAndRemove(context, Routes.loginRoute));
                          // navigatorAndRemove(context, Routes.loginRoute);
                        },
                        context: context,
                        okButtonName: LocaleKeys.delete.tr(),
                        cancelButtonName: LocaleKeys.cancel.tr(),
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextCustom(
                              text: LocaleKeys.deleteAccount,
                              fontWeight: FontWeightManager.semiBold,
                              fontSize: FontSize.s18,
                            ),
                            const RSizedBox.vertical(AppSize.s16),
                            TextCustom(
                              text: LocaleKeys.deleteAccountWarning,
                              textAlign: TextAlign.center,
                              textStyle: getMediumGilroyStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            const RSizedBox.vertical(AppSize.s16),
                          ],
                        ));
                  } else {
                    navigator(context, clinicCubit.routeName[index]);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
