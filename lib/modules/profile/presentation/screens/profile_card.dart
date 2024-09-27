// ignore_for_file: use_build_context_synchronously

import 'package:doctor_ack/core/local/cache_helper.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/modules/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:doctor_ack/modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import 'package:doctor_ack/modules/webViews/controllers/web_view_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/widgets/component.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../language/presentation/pages/lang_view.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_component.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: ProfileCubit.get(context).refreshController,
      onRefresh: () => ProfileCubit.get(context).getProfileFun(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s100.h * 3,
              width: context.width,
              child: BlocProvider.value(
                value: BlocProvider.of<ProfileCubit>(context)..getProfileFun(),
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is LogoutState) {
                      navigatorAndRemove(context, Routes.loginRoute);
                    }
                  },
                  builder: (context, state) {
                    return Stack(
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
                              ? AppSize.s100.w * 2.5
                              : AppSize.s16.w,
                          child: Container(
                            padding:
                                EdgeInsets.only(top: AppPadding.p100 / 1.3),
                            alignment: Alignment.center,
                            // height: (AppSize.s100*2).h,
                            width: (AppSize.s100 * 3.4).w,
                            color: ColorManager.white,
                            child: switch (state) {
                              GetProfileSuccessState() => Column(
                                  children: [
                                    TextCustom(
                                      text: state.profileEntity.resultEntity
                                          .response.name,
                                      fontSize: FontSize.s22,
                                      fontWeight: FontWeightManager.medium,
                                    ),
                                    SizedBox(
                                      height: AppSize.s10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const SvgPictureCustom(
                                              assetsName: IconAssets.email,
                                              color: ColorManager.black,
                                            ),
                                            SizedBox(
                                              width: AppSize.s6.w,
                                            ),
                                            TextCustom(
                                              text: state.profileEntity
                                                  .resultEntity.response.email,
                                              textStyle: getMediumGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s12,
                                                  height: 0.17),
                                            ),
                                          ],
                                        ),
                                        const SvgPictureCustom(
                                          assetsName: IconAssets.divider,
                                          color: ColorManager.grey,
                                        ),
                                        Row(
                                          children: [
                                            const SvgPictureCustom(
                                              assetsName:
                                                  IconAssets.callCalling,
                                              color: ColorManager.black,
                                            ),
                                            SizedBox(
                                              width: AppSize.s6.w,
                                            ),
                                            TextCustom(
                                              text: state
                                                  .profileEntity
                                                  .resultEntity
                                                  .response
                                                  .mobilePhone,
                                              textStyle: getMediumGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s12,
                                                  height: 0.17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              GetProfileErrorState() => TextCustom(
                                  text: state.message,
                                ),
                              GetProfileLoadingState() => ShimmerCustom(
                                  child: Container(
                                    color: ColorManager.lightGrey,
                                  ),
                                ),
                              _ => ShimmerCustom(
                                  child: Container(
                                    color: ColorManager.lightGrey,
                                  ),
                                ),
                            },
                          ),
                        ),
                        Positioned(
                          top: (AppSize.s100).h,
                          right: context.tablet
                              ? context.width / 2.3
                              : (AppSize.s100 * 1.21).w,
                          child: Container(
                            width: (AppSize.s100 * 1.32).h,
                            height: (AppSize.s100 * 1.32).h,
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 6,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: switch (state) {
                              GetProfileSuccessState() => Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: CachedNetworkImageCustom(
                                    boarder: AppSize.s100,
                                    boxFit: BoxFit.fill,
                                    url: state.profileEntity.resultEntity
                                        .response.imageUrl,
                                  ),
                                ),
                              GetProfileErrorState() => Container(
                                  decoration: const BoxDecoration(
                                      color: ColorManager.secondary,
                                      shape: BoxShape.circle),
                                ),
                              GetProfileLoadingState() => ShimmerCustom(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: ColorManager.lightGrey,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              _ => ShimmerCustom(
                                  child: Container(
                                    color: ColorManager.lightGrey,
                                  ),
                                ),
                            },

                            // const CachedNetworkImageCustom(
                            //   boarder: AppSize.s80,
                            //   url: ImageNetwork.profile1Image,
                            //   boxFit: BoxFit.fill,
                            // ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s20.h,
            ),
            const ProfileWidget(),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var profileCubit = ProfileCubit.get(context);
            var editProfileCubit = EditProfileCubit.get(context);

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: profileCubit.iconName.length,
              itemBuilder: (context, index) => ProfileComponent(
                name: profileCubit.name[index],
                iconName: profileCubit.iconName[index],
                screen: profileCubit.routeName[index],
                onTap: () {
                  if (index == 0) {
                    if (state is GetProfileSuccessState) {
                      editProfileCubit.image =
                          state.profileEntity.resultEntity.response.imageUrl;
                      editProfileCubit.userNameController.text =
                          state.profileEntity.resultEntity.response.name;
                      editProfileCubit.phoneNumberController.text =
                          state.profileEntity.resultEntity.response.mobilePhone;
                      editProfileCubit.emailController.text =
                          state.profileEntity.resultEntity.response.email;

                      editProfileCubit.name =
                          state.profileEntity.resultEntity.response.name;
                      editProfileCubit.phone =
                          state.profileEntity.resultEntity.response.mobilePhone;
                      editProfileCubit.email =
                          state.profileEntity.resultEntity.response.email;
                      navigator(context, Routes.editProfileRoute);
                    }
                  } else if (index == 3) {
                    bottomSheetCustom(
                        height: AppSize.s100.h * 2.8,
                        context: context,
                        body: Material(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s30.r),
                              topRight: Radius.circular(AppSize.s30.r)),
                          child: const LanguageView(),
                        ));
                  } else if (index == 4) {
                    WebViewCubit.get(context).terms = false;
                    navigator(context, Routes.webViewRoute);
                  } else if (index == 5) {
                    WebViewCubit.get(context).terms = true;
                    navigator(context, Routes.webViewRoute);
                  } else if (index == 7) {
                    dialogCustom(
                        pressEventOk: () async {
                          AppConstants.token = '';
                          AppConstants.expireToken = '';
                          AppConstants.type = '';
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
                  } else if (index == 8) {
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
                    navigator(context, profileCubit.routeName[index]);
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
