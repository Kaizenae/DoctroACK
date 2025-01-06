// ignore_for_file: deprecated_member_use

import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/clinic_cubit/clinic_cubit.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/clinic_cubit/clinic_state.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/toggle_cubit/toggle_cubit.dart';
import 'package:doctor_ack/modules/service/presentation/controller/service_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/utils/constants_manager.dart';
// import '../../../../core/utils/dynamic_link.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/share/share.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../../../favourite/presentation/controllers/add_remove_favourite_cubit/add_remove_favourite_state.dart';
import '../../../favourite/presentation/controllers/add_remove_favourite_cubit/add_removefavourites_cubit.dart';
import '../../../favourite/presentation/controllers/favourites_cubit/favourites_cubit.dart';
import 'clinic_card.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ClinicBody extends StatelessWidget {
  const ClinicBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: BlocProvider.of<ClinicCubit>(context)..getClinic(),
        child: BlocConsumer<ClinicCubit, ClinicState>(
          listener: (context, state) {
            if (state is GetClinicSuccessState) {
              ToggleCubit.get(context).isFavourite =
                  state.clinicEntity.resultEntity.response.favourite;
            }
          },
          builder: (context, state) {
            var clinicCubit = ClinicCubit.get(context);
            return Stack(
              children: [
                switch (state) {
                  GetClinicSuccessState() => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImageCustom(
                          // width: AppSize.s100,
                          height: (AppSize.s100 * 2.5).h,
                          // boarder: AppSize.s24.r,
                          url: state.clinicEntity.resultEntity.response.icon,
                        ),
                        SizedBox(
                          height: (AppSize.s80 * 1.2).h,
                        ),
                        SizedBox(
                          height: context.tablet
                              ? context.height / 1.2
                              : (AppSize.s100 * 4.4).h,
                          width: context.tablet
                              ? context.width / 1.2
                              : (AppSize.s100 * 3.43).w,
                          child: Column(
                            children: [
                              TabBarCustom(
                                radius: AppSize.s24.r,
                                myTabs: [
                                  Tab(
                                    text: LocaleKeys.services.tr(),
                                  ),
                                  Tab(
                                    text: LocaleKeys.aboutTheClinic.tr(),
                                  ),
                                ],
                                widgets: [
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: AppPadding.p20),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        runSpacing: AppSize.s16,
                                        spacing: AppSize.s20,
                                        children: List.generate(
                                            state.clinicEntity.resultEntity
                                                .response.services.length,
                                            (index) => FadeIn(
                                                  // duration: const Duration(milliseconds: 250),

                                                  child: Container(
                                                    height:
                                                        (AppSize.s100 * 2.9).h,
                                                    width:
                                                        (AppSize.s100 * 1.6).w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize.s20
                                                                        .r)),
                                                    child: InkWell(
                                                      onTap: () {
                                                        ServiceCubit.get(
                                                                    context)
                                                                .serviceID =
                                                            state
                                                                .clinicEntity
                                                                .resultEntity
                                                                .response
                                                                .services[index]
                                                                .id;
                                                        navigator(
                                                            context,
                                                            Routes
                                                                .serviceClinicRoute);
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: AppSize.s12,
                                                            child: Container(
                                                              height:
                                                                  (AppSize.s100 *
                                                                          1.76)
                                                                      .h,
                                                              width:
                                                                  (AppSize.s100 *
                                                                          1.6)
                                                                      .w,
                                                              decoration: BoxDecoration(
                                                                  color: index %
                                                                              2 ==
                                                                          0
                                                                      ? ColorManager
                                                                          .pink
                                                                      : ColorManager
                                                                          .yellowL,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          AppSize
                                                                              .s20
                                                                              .r)),
                                                              child: Stack(
                                                                children: [
                                                                  const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          SvgPictureCustom(
                                                                        assetsName:
                                                                            IconAssets.circle,
                                                                        color:
                                                                            null,
                                                                        height:
                                                                            AppSize.s80,
                                                                        width: AppSize
                                                                            .s80,
                                                                      )),
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          SvgPictureCustom(
                                                                        assetsName: index % 2 ==
                                                                                0
                                                                            ? IconAssets.lineB
                                                                            : IconAssets.lineT,
                                                                        color:
                                                                            null,
                                                                        height:
                                                                            AppSize.s80,
                                                                        width: AppSize
                                                                            .s80,
                                                                      )),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(AppSize
                                                                              .s20
                                                                              .r),
                                                                          bottomRight: Radius.circular(AppSize
                                                                              .s20
                                                                              .r)),
                                                                      child: CachedNetworkImageCustom(
                                                                          height: (AppSize.s100 * 1)
                                                                              .h,
                                                                          width: AppSize
                                                                              .s100
                                                                              .w,
                                                                          boxFit: BoxFit
                                                                              .cover,
                                                                          boarder: AppSize
                                                                              .s0,
                                                                          url: state
                                                                              .clinicEntity
                                                                              .resultEntity
                                                                              .response
                                                                              .services[index]
                                                                              .icon),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: AppSize
                                                                        .s16,
                                                                    left: AppSize
                                                                        .s10,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: AppPadding
                                                                              .p6,
                                                                          vertical:
                                                                              AppPadding.p2),
                                                                      height:
                                                                          AppSize
                                                                              .s20
                                                                              .h,
                                                                      width: AppSize
                                                                          .s50
                                                                          .w,
                                                                      decoration: BoxDecoration(
                                                                          color: ColorManager
                                                                              .primary,
                                                                          borderRadius: BorderRadius.circular(AppSize
                                                                              .s30
                                                                              .r)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          SvgPictureCustom(
                                                                            assetsName:
                                                                                IconAssets.star2,
                                                                            color:
                                                                                null,
                                                                            height:
                                                                                AppSize.s16.h,
                                                                            width:
                                                                                AppSize.s16.w,
                                                                          ),
                                                                          TextCustom(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              fontFamily: 'Gilroy',
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.white,
                                                                              fontWeight: FontWeightManager.regular,
                                                                            ),
                                                                            text:
                                                                                state.clinicEntity.resultEntity.response.services[index].rate.toStringAsFixed(1),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            // bottom:-10,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      AppPadding
                                                                          .p6),
                                                              width:
                                                                  (AppSize.s100 *
                                                                          1.35)
                                                                      .w,
                                                              height:
                                                                  (AppSize.s100 *
                                                                          1.3)
                                                                      .h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    ColorManager
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(AppSize
                                                                            .s10
                                                                            .r),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                          padding: EdgeInsets.all(AppPadding
                                                                              .p6),
                                                                          width: AppSize
                                                                              .s24
                                                                              .h,
                                                                          height: AppSize
                                                                              .s24
                                                                              .h,
                                                                          decoration:
                                                                              ShapeDecoration(
                                                                            color: index % 2 == 0
                                                                                ? ColorManager.pink
                                                                                : ColorManager.yellowL,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              SvgPictureCustom(
                                                                            assetsName:
                                                                                IconAssets.service1,
                                                                            color:
                                                                                ColorManager.serviceIconColor,
                                                                            width:
                                                                                AppSize.s10.h,
                                                                            height:
                                                                                AppSize.s10.h,
                                                                          )),
                                                                      SizedBox(
                                                                        width: AppSize
                                                                            .s4
                                                                            .w,
                                                                      ),
                                                                      SizedBox(
                                                                        width: AppSize
                                                                            .s80
                                                                            .w,
                                                                        child:
                                                                            TextCustom(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            fontSize:
                                                                                FontSize.s12,
                                                                            fontWeight:
                                                                                FontWeightManager.medium,
                                                                          ),
                                                                          text: state
                                                                              .clinicEntity
                                                                              .resultEntity
                                                                              .response
                                                                              .services[index]
                                                                              .name,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        AppSize
                                                                            .s4
                                                                            .h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: (AppSize.s100 *
                                                                            1.23)
                                                                        .w,
                                                                    height:
                                                                        AppSize
                                                                            .s40
                                                                            .h,
                                                                    child:
                                                                        TextCustom(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      text: state
                                                                          .clinicEntity
                                                                          .resultEntity
                                                                          .response
                                                                          .services[
                                                                              index]
                                                                          .description,
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy',
                                                                        fontSize:
                                                                            FontSize.s12,
                                                                        color: ColorManager
                                                                            .primary,
                                                                        fontWeight:
                                                                            FontWeightManager.regular,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButtonCustom(
                                                                    width:
                                                                        AppSize
                                                                            .s80
                                                                            .w,
                                                                    height:
                                                                        AppSize
                                                                            .s24
                                                                            .h,
                                                                    text: LocaleKeys
                                                                        .schedule,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        FontSize
                                                                            .s12,
                                                                    onPressed:
                                                                        () {
                                                                      ServiceCubit.get(context).serviceID = state
                                                                          .clinicEntity
                                                                          .resultEntity
                                                                          .response
                                                                          .services[
                                                                              index]
                                                                          .id;
                                                                      ServiceCubit.get(context).serviceName = state
                                                                          .clinicEntity
                                                                          .resultEntity
                                                                          .response
                                                                          .services[
                                                                              index]
                                                                          .name;
                                                                      navigator(
                                                                          context,
                                                                          Routes
                                                                              .serviceClinicRoute);
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: state
                                                                    .clinicEntity
                                                                    .resultEntity
                                                                    .response
                                                                    .services[
                                                                        index]
                                                                    .discount !=
                                                                0.0,
                                                            child: Positioned(
                                                              top: AppSize.s0,
                                                              right:
                                                                  AppSize.s18,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  SvgPictureCustom(
                                                                    assetsName:
                                                                        IconAssets
                                                                            .rectangleDisc,
                                                                    color: null,
                                                                    height:
                                                                        AppSize
                                                                            .s28
                                                                            .h,
                                                                    width:
                                                                        AppSize
                                                                            .s60
                                                                            .w,
                                                                  ),
                                                                  Positioned(
                                                                    top: AppSize
                                                                        .s4,
                                                                    child:
                                                                        TextCustom(
                                                                      text:
                                                                          '${(state.clinicEntity.resultEntity.response.services[index].discount / state.clinicEntity.resultEntity.response.services[index].price) * 100}% ${LocaleKeys.off.tr()}',
                                                                      textStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            FontSize.s12,
                                                                        fontFamily:
                                                                            'SF Pro Text',
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height:
                                                                            0,
                                                                        letterSpacing:
                                                                            -0.24,
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
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: AppPadding.p20),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                            text: LocaleKeys.aboutTheClinic,
                                            textStyle: TextStyle(
                                              color: ColorManager.primary,
                                              fontSize: FontSize.s18,
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                              height: 0,
                                              letterSpacing: -0.36,
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppSize.s8.h,
                                          ),
                                          ReadMoreText(
                                            state.clinicEntity.resultEntity
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
                                            colorClickableText:
                                                ColorManager.primary,
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
                                            trimCollapsedText:
                                                LocaleKeys.readMore.tr(),
                                            trimExpandedText:
                                                LocaleKeys.collapse.tr(),
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
                                                    BorderRadius.circular(
                                                        AppSize.s20.r),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextCustom(
                                                      text: LocaleKeys.address,
                                                      textStyle: TextStyle(
                                                        color: ColorManager
                                                            .primary,
                                                        fontSize: FontSize.s18,
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        fontWeight:
                                                            FontWeightManager
                                                                .semiBold,
                                                        height: 0,
                                                        letterSpacing: -0.36,
                                                      ),
                                                      fontWeight:
                                                          FontWeightManager
                                                              .bold,
                                                    ),
                                                    SizedBox(
                                                      // height: AppSize.s40.h,
                                                      width:
                                                          (AppSize.s100 * 2.2)
                                                              .w,
                                                      child: TextCustom(
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        text:
                                                            '${state.clinicEntity.resultEntity.response.address.street}, ${state.clinicEntity.resultEntity.response.address.state}, ${state.clinicEntity.resultEntity.response.address.city}',
                                                        textStyle: TextStyle(
                                                          color:
                                                              ColorManager.grey,
                                                          fontSize:
                                                              FontSize.s14,
                                                          fontFamily:
                                                              'Gilroy-SemiBold',
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                        ),
                                                        fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    bool check = await MapLauncher
                                                            .isMapAvailable(
                                                                MapType
                                                                    .google) ??
                                                        false;
                                                    if (check) {
                                                      await MapLauncher
                                                          .showMarker(
                                                        mapType: MapType.google,
                                                        coords: Coords(
                                                            state
                                                                .clinicEntity
                                                                .resultEntity
                                                                .response
                                                                .lat,
                                                            state
                                                                .clinicEntity
                                                                .resultEntity
                                                                .response
                                                                .long),
                                                        title: state
                                                            .clinicEntity
                                                            .resultEntity
                                                            .response
                                                            .name,
                                                        description: state
                                                            .clinicEntity
                                                            .resultEntity
                                                            .response
                                                            .description,
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    width: AppSize.s70.w,
                                                    height: AppSize.s80.h,
                                                    decoration: ShapeDecoration(
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            ImageAssets
                                                                .mapAddress),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                    ),
                                                  ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  GetClinicErrorState() => ErrorsWidget(
                      onPress: () => clinicCubit.getClinic(),
                      text: state.message),
                  GetClinicLoadingState() => ShimmerCustom(
                        child: Container(
                      height: AppSize.s100 * 3,
                      color: ColorManager.grey,
                    )),
                  _ => ShimmerCustom(
                        child: Container(
                      height: AppSize.s100 * 3,
                      color: ColorManager.grey,
                    ))
                },
                switch (state) {
                  GetClinicSuccessState() => ClinicCard(
                      id: state.clinicEntity.resultEntity.response.id,
                      rate: state.clinicEntity.resultEntity.response.rate
                          .toStringAsFixed(1),
                      name: state.clinicEntity.resultEntity.response.name,
                      experience: state
                          .clinicEntity.resultEntity.response.numExperience
                          .toString(),
                      expertise:
                          state.clinicEntity.resultEntity.response.expertise,
                      icon: state.clinicEntity.resultEntity.response.icon,
                      patient: state
                          .clinicEntity.resultEntity.response.numPatient
                          .toString(),
                      phone: state.clinicEntity.resultEntity.response.phone,
                    ),
                  GetClinicErrorState() => ErrorsWidget(
                      onPress: () => clinicCubit.getClinic(),
                      text: state.message),
                  GetClinicLoadingState() => ShimmerCustom(child: Container()),
                  _ => ShimmerCustom(child: Container())
                },
                Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: Row(
                    children: [
                      state is GetClinicSuccessState
                          ? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPictureCustom(
                                assetsName: AppConstants.language
                                    ? IconAssets.arrowRight
                                    : IconAssets.arrowLeft,
                                color: state.clinicEntity.resultEntity.response
                                        .icon.isNotEmpty
                                    ? ColorManager.white
                                    : ColorManager.primary,
                              ))
                          : InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPictureCustom(
                                assetsName: AppConstants.language
                                    ? IconAssets.arrowRight
                                    : IconAssets.arrowLeft,
                                color: ColorManager.primary,
                              )),
                      const Spacer(),
                      BlocBuilder<ToggleCubit, ToggleState>(
                        builder: (context, toggleState) {
                          var toggleCubit = ToggleCubit.get(context);
                          return BlocConsumer<AddRemoveFavouritesCubit,
                              AddRemoveFavouritesState>(
                            listener: (context, state) {
                              if (state is AddRemoveFavouriteSuccessState) {
                                FavouritesCubit.get(context).getFavourite();
                                if (toggleCubit.isFavourite) {
                                  showToast(context,
                                      message:
                                          LocaleKeys.toastClinicFavourite.tr(),
                                      type: MessageType.success);
                                } else {
                                  showToast(context,
                                      message:
                                          LocaleKeys.toastRemoveFavourite.tr(),
                                      type: MessageType.success);
                                }
                              } else if (state
                                  is AddRemoveFavouriteErrorState) {
                                showToast(context,
                                    message: state.message,
                                    type: MessageType.error);
                              }
                            },
                            builder: (context, favState) {
                              var removeFavCubit =
                                  AddRemoveFavouritesCubit.get(context);

                              return InkWell(
                                  onTap: state is GetClinicSuccessState
                                      ? () {
                                          removeFavCubit.id = state.clinicEntity
                                              .resultEntity.response.id;
                                          removeFavCubit.isClinic = true;
                                          removeFavCubit.endpoint = toggleCubit
                                                  .isFavourite
                                              ? EndPoints
                                                  .removeFavouriteEndpoint
                                              : EndPoints.addFavouriteEndpoint;
                                          // Optimistically update the UI
                                          toggleCubit.toggleFav();

                                          removeFavCubit.addRemoveFavourite();
                                        }
                                      : () {},
                                  child: Container(
                                      width: AppSize.s34.w,
                                      height: AppSize.s34.w,
                                      padding: EdgeInsets.all(AppPadding.p6),
                                      decoration: ShapeDecoration(
                                        color: Colors.white
                                            .withOpacity(0.6000000238418579),
                                        shape: const OvalBorder(),
                                      ),
                                      child: SvgPictureCustom(
                                        assetsName: toggleCubit.isFavourite
                                            ? IconAssets.favorite
                                            : IconAssets.heart,
                                        color: toggleCubit.isFavourite
                                            ? ColorManager.red
                                            : null,
                                      )));
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: AppSize.s10.w,
                      ),
                      InkWell(
                        onTap: state is GetClinicSuccessState
                            ? () {
                                shareFun(
                                  name: state.clinicEntity.resultEntity.response
                                      //             .name
                                      .toString(),
                                );
                              }
                            : null,
                        child: SvgPictureCustom(
                          assetsName: IconAssets.share,
                          color: null,
                          height: AppSize.s34.h,
                          width: AppSize.s34.h,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
