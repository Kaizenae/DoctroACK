import 'dart:math';
import 'package:doctor_ack/core/general_controllers/location_controller/location_cubit.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/modules/profile/presentation/cubit/profile_cubit.dart';
import 'package:doctor_ack/modules/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/app_widgets/clinic_card_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../all_clinics/presentation/controllers/all_clinics_cubit/all_clinics_cubit.dart';
import '../../../categories/presentation/controllers/cubit/get_categories_cubit.dart';
import '../../../categories/presentation/controllers/cubit/get_categories_state.dart';
import 'banners_widget.dart';
import 'home_services.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('Home'),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSize.s30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.s44.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        // radius: AppSize.s40.r,
                        backgroundColor: ColorManager.secondary,
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return state is GetProfileSuccessState
                                ? CachedNetworkImageCustom(
                                    boarder: AppSize.s44.r,
                                    boxFit: BoxFit.fill,
                                    url: state
                                        .profileEntity
                                        .resultEntity
                                        .response
                                        .imageUrl)
                                : Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.secondary,
                                        borderRadius: BorderRadius.circular(
                                            AppSize.s44.r)),
                                  );
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              return state is GetProfileSuccessState
                                  ? TextCustom(
                                      text: state.profileEntity.resultEntity
                                          .response.name,
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.regular,
                                    )
                                  : ShimmerCustom(
                                      child: TextCustom(
                                      text: 'DOCTORACK',
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.regular,
                                    ));
                            },
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<LocationCubit>(context)
                              ..getAddress(),
                            child: BlocConsumer<LocationCubit, LocationState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                var locationCubit = LocationCubit.get(context);
                                return Row(
                                  children: [
                                    const SvgPictureCustom(
                                      assetsName: IconAssets.locationIcon,
                                      color: ColorManager.black,
                                    ),
                                    SizedBox(
                                      width: AppSize.s8.w,
                                    ),
                                    TextCustom(
                                      text: locationCubit.palcename,
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.regular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: (AppSize.s80 * 1.05).w,
                        height: AppSize.s40.h,
                        decoration: BoxDecoration(
                          color: ColorManager.white1,
                          borderRadius: BorderRadius.circular(AppSize.s20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  navigator(context, Routes.notificationsRoute);
                                },
                                child: const SvgPictureCustom(
                                    assetsName: IconAssets.notifications)),
                            const VerticalDivider(
                                color: ColorManager.divider,
                                thickness: 0.8,
                                width: AppSize.s18,
                                indent: 6.0,
                                endIndent: 6),
                            InkWell(
                                onTap: () {
                                  navigator(context, Routes.favoritesRoute);
                                },
                                child: const SvgPictureCustom(
                                    assetsName: IconAssets.heart)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          Banners(title: LocaleKeys.featuredOffers.tr()),
          SizedBox(
            height: AppSize.s20.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Divider(
                    thickness: 0.2,
                    height: AppSize.s40,
                    color: ColorManager.red,
                    endIndent: AppSize.s20,
                    indent: 0,
                  )),
                  Expanded(
                    flex: 3,
                    child: TextCustom(
                      text: LocaleKeys.categories,
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        navigator(context, Routes.categoriesScreen);
                      },
                      icon: SvgPictureCustom(
                        assetsName: AppConstants.language
                            ? IconAssets.arrowLeft
                            : IconAssets.arrowRight,
                      ))
                ],
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              BlocProvider.value(
                value: BlocProvider.of<GetCategoriesCubit>(context)
                  ..getCategories(),
                child: BlocBuilder<GetCategoriesCubit, CategoriesStates>(
                  builder: (context, state) {
                    var categoriesCubit = GetCategoriesCubit.get(context);
                    return switch (state) {
                      GetCategoriesSuccessState() => SizedBox(
                          height: (AppSize.s100 * 1.7).h,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(right: AppPadding.p20),
                              height: (AppSize.s100 * 1.7).h,
                              width: (AppSize.s100 * 1.05).w,
                              decoration: BoxDecoration(
                                color: ImageNetwork.categoryColor[Random()
                                    .nextInt(
                                        ImageNetwork.categoryColor.length)],
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20.r),
                              ),
                              child: InkWell(
                                onTap: () {
                                  AllServicesCubit.get(context).categoryId =
                                      state.categoriesEntity.resultEntity
                                          .response[index].id;
                                  navigator(context, Routes.allServicesScreen);
                                },
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
                                      alignment: Alignment.bottomCenter,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(AppSize.s20.r),
                                            bottomRight:
                                                Radius.circular(AppSize.s20.r)),
                                        child: CachedNetworkImageCustom(
                                            height: (AppSize.s100 * 1.2).h,
                                            width: AppSize.s100.w - 2,
                                            boxFit: BoxFit.cover,
                                            boarder: AppSize.s0,
                                            url:
                                                state
                                                    .categoriesEntity
                                                    .resultEntity
                                                    .response[index]
                                                    .icon),
                                      ),
                                    ),
                                    Positioned(
                                        top: AppSize.s20,
                                        left: AppSize.s10,
                                        child: TextCustom(
                                          textStyle: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: FontSize.s14,
                                            fontWeight:
                                                FontWeightManager.regular,
                                          ),
                                          text: state
                                              .categoriesEntity
                                              .resultEntity
                                              .response[index]
                                              .name,
                                          fontSize: FontSize.s14,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            itemCount: state
                                .categoriesEntity.resultEntity.response.length,
                          ),
                        ),
                      GetCategoriesErrorState() => HErrorsWidget(
                          onPress: () => categoriesCubit.getCategories(),
                          text: state.message),
                      GetCategoriesLoadingState() => ShimmerCustom(
                            child: SizedBox(
                          height: (AppSize.s100 * 1.7).h,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(right: AppPadding.p20),
                              height: (AppSize.s100 * 1.7).h,
                              width: AppSize.s100.w,
                              decoration: BoxDecoration(
                                color: ColorManager.lightGrey,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20.r),
                              ),
                            ),
                            itemCount: 3,
                          ),
                        )),
                      _ => const SizedBox(),
                    };
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          const FeaturedClinics(),
          SizedBox(
            height: AppSize.s20.h,
          ),
          const HomeServices(title: LocaleKeys.services),
        ],
      ),
    );
  }
}

class FeaturedClinics extends StatelessWidget {
  const FeaturedClinics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
                child: Divider(
              thickness: 0.2,
              height: AppSize.s40,
              color: ColorManager.red,
              endIndent: AppSize.s20,
              indent: 0,
            )),
            Expanded(
              flex: 3,
              child: TextCustom(
                text: LocaleKeys.featuredClinics,
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            IconButton(
                onPressed: () {
                  navigator(context, Routes.allClinicsScreen);
                },
                icon: SvgPictureCustom(
                  assetsName: AppConstants.language
                      ? IconAssets.arrowLeft
                      : IconAssets.arrowRight,
                ))
          ],
        ),
        SizedBox(
          height: AppSize.s8.h,
        ),
        SizedBox(
            height: (AppSize.s100 * 1.84).h,
            child: BlocProvider.value(
              value: BlocProvider.of<AllClinicsCubit>(context)..getAllClinics(),
              child: BlocBuilder<AllClinicsCubit, AllClinicsState>(
                builder: (context, state) {
                  var allClinics = AllClinicsCubit.get(context);
                  return switch (state) {
                    GetAllClinicsSuccessState() => ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppPadding.p16),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(right: AppPadding.p18),
                          child: ClinicCardWidget(
                            key: const Key('AllClinics'),
                            index: index,
                            id: state.allClinicsEntity.resultEntity
                                .response[index].id,
                            length: state
                                .allClinicsEntity.resultEntity.response.length,
                            network: true,
                            city: state.allClinicsEntity.resultEntity
                                .response[index].city,
                            description: state.allClinicsEntity.resultEntity
                                .response[index].description,
                            imageUrl: state.allClinicsEntity.resultEntity
                                .response[index].image,
                            name: state.allClinicsEntity.resultEntity
                                .response[index].name,
                            rate: state.allClinicsEntity.resultEntity
                                .response[index].rate
                                .toStringAsFixed(1),
                          ),
                        ),
                        itemCount: state.allClinicsEntity.resultEntity.response
                                    .length <
                                5
                            ? state
                                .allClinicsEntity.resultEntity.response.length
                            : 5,
                      ),
                    GetAllClinicsErrorState() => HErrorsWidget(
                        onPress: () => allClinics.getAllClinics(),
                        text: state.message),
                    GetAllClinicsLoadingState() => ShimmerCustom(
                          child: Row(
                        children: List.generate(
                            2,
                            (index) => FadeIn(
                                  // duration: const Duration(milliseconds: 250),

                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: AppPadding.p16),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p8,
                                      ),
                                      // margin: EdgeInsets.only(right: AppPadding.p20),
                                      height: (AppSize.s100 * 1.73).h,
                                      width: (AppSize.s100 * 1.61).w,
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? ColorManager.primary
                                            : ColorManager.secondary,
                                        borderRadius: BorderRadius.circular(
                                            AppSize.s20.r),
                                      ),
                                    ),
                                  ),
                                )),
                      )),
                    _ => ShimmerCustom(
                          child: Row(
                        children: List.generate(
                            2,
                            (index) => FadeIn(
                                  // duration: const Duration(milliseconds: 250),

                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: AppPadding.p16),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p8,
                                      ),
                                      // margin: EdgeInsets.only(right: AppPadding.p20),
                                      height: (AppSize.s100 * 1.73).h,
                                      width: (AppSize.s100 * 1.61).w,
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? ColorManager.primary
                                            : ColorManager.secondary,
                                        borderRadius: BorderRadius.circular(
                                            AppSize.s20.r),
                                      ),
                                    ),
                                  ),
                                )),
                      )),
                  };
                },
              ),
            ))
      ],
    );
  }
}
