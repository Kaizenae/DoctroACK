// ignore_for_file: deprecated_member_use

import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
// import 'package:doctor_ack/core/utils/dynamic_link.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/injection_imports.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/service/domain/entities/service_entity.dart';
import 'package:doctor_ack/modules/webViews/controllers/web_view_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/drop_down/drop_dwon_button.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/share/share.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../favourite/presentation/controllers/add_remove_favourite_cubit/add_remove_favourite_state.dart';
import '../../../favourite/presentation/controllers/toggle_cubit/toggle_cubit.dart';
import '../../../reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import '../../../user/presentation/controllers/users_cubit/users_cubit.dart';
import '../controller/service_state.dart';

class ServiceClinicScreen extends StatefulWidget {
  const ServiceClinicScreen({super.key});

  @override
  State<ServiceClinicScreen> createState() => _ServiceClinicScreenState();
}

class _ServiceClinicScreenState extends State<ServiceClinicScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        body: SafeArea(
      child: BlocProvider.value(
        value: BlocProvider.of<ServiceCubit>(context)..getService(),
        child: BlocConsumer<ServiceCubit, ServiceState>(
          listener: (context, state) {
            if (state is GetServiceSuccessState) {
              ToggleCubit.get(context).isFavourite =
                  state.serviceEntity.resultEntity.response.favourite;
              UsersCubit.get(context).toToken =
                  state.serviceEntity.resultEntity.response.notification;
            }
          },
          builder: (context, state) {
            var serviceCubit = ServiceCubit.get(context);
            return switch (state) {
              GetServiceSuccessState() => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: (AppSize.s100 * 2.6).h,
                        width: context.width,
                        child: Stack(
                          children: [
                            Container(
                              color: ColorManager.pink,
                              height: (AppSize.s100 * 2.3).h,
                              width: context.width,
                            ),
                            Positioned(
                              bottom: AppSize.s30.h,
                              right: AppSize.s70.w,
                              child: CachedNetworkImageCustom(
                                  width: (AppSize.s100 * 2.2),
                                  height: (AppSize.s100 * 1.6).h,
                                  boxFit: BoxFit.fill,
                                  url: state.serviceEntity.resultEntity.response
                                      .icon),
                            ),
                            Positioned(
                              top: AppSize.s10,
                              child: SizedBox(
                                width: context.width,
                                child: Padding(
                                  padding: EdgeInsets.all(AppPadding.p16),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: SvgPictureCustom(
                                            assetsName: AppConstants.language
                                                ? IconAssets.arrowRight
                                                : IconAssets.arrowLeft,
                                            color: ColorManager.black,
                                          )),
                                      const SizedBox(
                                        width: AppSize.s10,
                                      ),
                                      Expanded(
                                        child: TextCustom(
                                          text: state.serviceEntity.resultEntity
                                              .response.name,
                                          overflow: TextOverflow.ellipsis,
                                          textStyle: TextStyle(
                                            fontSize: FontSize.s18,
                                            fontFamily: 'Marcellus',
                                            fontWeight:
                                                FontWeightManager.medium,
                                            height: 0,
                                            letterSpacing: -0.36,
                                          ),
                                        ),
                                      ),
                                      BlocBuilder<ToggleCubit, ToggleState>(
                                        builder: (context, toggleState) {
                                          var toggleCubit =
                                              ToggleCubit.get(context);
                                          return BlocConsumer<
                                              AddRemoveFavouritesCubit,
                                              AddRemoveFavouritesState>(
                                            listener: (context, state) {
                                              if (state
                                                  is AddRemoveFavouriteSuccessState) {
                                                if (toggleCubit.isFavourite) {
                                                  FavouritesCubit.get(context)
                                                      .getFavourite();
                                                  showToast(context,
                                                      message: LocaleKeys
                                                          .toastTreatmentFavourite
                                                          .tr(),
                                                      type:
                                                          MessageType.success);
                                                } else {
                                                  showToast(context,
                                                      message: LocaleKeys
                                                          .toastRemoveFavourite
                                                          .tr(),
                                                      type:
                                                          MessageType.success);
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
                                                  AddRemoveFavouritesCubit.get(
                                                      context);
                                              return InkWell(
                                                onTap: () {
                                                  removeFavCubit.id = state
                                                      .serviceEntity
                                                      .resultEntity
                                                      .response
                                                      .id;
                                                  removeFavCubit.isClinic =
                                                      false;
                                                  removeFavCubit.endpoint = toggleCubit
                                                          .isFavourite
                                                      ? EndPoints
                                                          .removeFavouriteEndpoint
                                                      : EndPoints
                                                          .addFavouriteEndpoint;
                                                  toggleCubit.toggleFav();

                                                  removeFavCubit
                                                      .addRemoveFavourite();
                                                },
                                                child: Container(
                                                  width: AppSize.s34.w,
                                                  height: AppSize.s34.w,
                                                  padding: EdgeInsets.all(
                                                      AppPadding.p6),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white
                                                        .withOpacity(
                                                            0.6000000238418579),
                                                    shape: const OvalBorder(),
                                                  ),
                                                  child: SvgPictureCustom(
                                                    assetsName: toggleCubit
                                                            .isFavourite
                                                        ? IconAssets.favorite
                                                        : IconAssets.heart,
                                                    color:
                                                        toggleCubit.isFavourite
                                                            ? ColorManager.red
                                                            : null,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: AppSize.s10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          shareFun(
                                            name: state.serviceEntity
                                                .resultEntity.response.name
                                                .toString(),
                                          );
                                        },
                                        child: SvgPictureCustom(
                                          assetsName: IconAssets.share,
                                          color: null,
                                          height: AppSize.s34.h,
                                          width: AppSize.s34.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: AppSize.s12,
                              right: AppSize.s18,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p10,
                                    vertical: AppPadding.p8),
                                height: AppSize.s40.h,
                                width: AppSize.s80.w,
                                decoration: ShapeDecoration(
                                  color: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s50.r),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    ReviewsCubit.get(context).isClinic = false;
                                    ReviewsCubit.get(context).clinicID = state
                                        .serviceEntity.resultEntity.response.id;
                                    ReviewsCubit.get(context).clinicRate = state
                                        .serviceEntity
                                        .resultEntity
                                        .response
                                        .rate
                                        .toStringAsFixed(1);
                                    ReviewsCubit.get(context).clinicName = state
                                        .serviceEntity
                                        .resultEntity
                                        .response
                                        .name;
                                    navigator(
                                        context, Routes.clinicReviewsRoute);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        text: state.serviceEntity.resultEntity
                                            .response.rate
                                            .toStringAsFixed(1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppPadding.p16),
                        child: Row(
                          children: [
                            Container(
                                width: AppSize.s40.h,
                                height: AppSize.s40.h,
                                padding: EdgeInsets.all(AppPadding.p10),
                                decoration: ShapeDecoration(
                                  color: ColorManager.caffe1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s50.r),
                                  ),
                                ),
                                child: const SvgPictureCustom(
                                  assetsName: IconAssets.service1,
                                  color: ColorManager.serviceIconColor,
                                )),
                            SizedBox(
                              width: AppSize.s4.w,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  ClinicCubit.get(context).clinicID = state
                                      .serviceEntity
                                      .resultEntity
                                      .response
                                      .clinicID;
                                  navigator(context, Routes.clinicRoute);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: (AppSize.s100 * 2).w,
                                      child: TextCustom(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textStyle: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: FontSize.s18,
                                          fontWeight: FontWeightManager.medium,
                                          height: 0,
                                          letterSpacing: -0.36,
                                        ),
                                        text: state.serviceEntity.resultEntity
                                            .response.clinicName,
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
                                          width: AppSize.s4.w,
                                        ),
                                        TextCustom(
                                          text: state.serviceEntity.resultEntity
                                              .response.city,
                                          textStyle: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: FontSize.s12,
                                            color: ColorManager.grey,
                                            fontWeight:
                                                FontWeightManager.regular,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state.serviceEntity.resultEntity.response
                                              .discount !=
                                          0
                                      ? Row(
                                          children: [
                                            TextCustom(
                                              text:
                                                  '${LocaleKeys.aED.tr()}${state.serviceEntity.resultEntity.response.priceWithoutDiscount.toStringAsFixed(0)}',
                                              textAlign: TextAlign.start,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              textStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s18,
                                                fontFamily: 'Gilroy-SemiBold',
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                // height: 0.05,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: state
                                                      .serviceEntity
                                                      .resultEntity
                                                      .response
                                                      .discount !=
                                                  0.0,
                                              child: Positioned(
                                                top: AppSize.s0,
                                                right: AppSize.s2,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPictureCustom(
                                                      assetsName: IconAssets
                                                          .rectangleDisc,
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
                                                          fontSize:
                                                              FontSize.s12,
                                                          fontFamily:
                                                              'SF Pro Text',
                                                          fontWeight:
                                                              FontWeight.w600,
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
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      AboutServiceWidget(
                        advice: state.serviceEntity.resultEntity.response.advice
                                .isNotEmpty
                            ? state.serviceEntity.resultEntity.response.advice
                            : [],
                        description: state
                            .serviceEntity.resultEntity.response.description,
                        doctors:
                            state.serviceEntity.resultEntity.response.doctors,
                      ),
                    ],
                  ),
                ),
              GetServiceErrorState() => ErrorsWidget(
                  onPress: () => serviceCubit.getService(),
                  text: state.message,
                ),
              GetServiceLoadingState() => ShimmerCustom(
                    child: Column(
                  children: [
                    Container(
                      color: ColorManager.pink,
                      height: (AppSize.s100 * 2.6).h,
                      width: context.width,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      child: Row(
                        children: [
                          Container(
                              width: AppSize.s40.h,
                              height: AppSize.s40.h,
                              padding: EdgeInsets.all(AppPadding.p10),
                              decoration: ShapeDecoration(
                                color: ColorManager.caffe1,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s50.r),
                                ),
                              ),
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
                                width: (AppSize.s100 * 2).w,
                                child: TextCustom(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeightManager.medium,
                                    height: 0,
                                    letterSpacing: -0.36,
                                  ),
                                  text: 'Skin & Hair Clinic',
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
                                    width: AppSize.s4.w,
                                  ),
                                  TextCustom(
                                    text: 'Dubai Marina',
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
                              ),
                            ],
                          ),
                          TextCustom(
                            text: '\$115.25',
                            textAlign: TextAlign.start,
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
                    ),
                  ],
                )),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    ));
  }
}

class AboutServiceWidget extends StatelessWidget {
  const AboutServiceWidget({
    super.key,
    required this.advice,
    required this.description,
    required this.doctors,
  });

  final List<String> advice;
  final List<DoctorEntity> doctors;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: CustomDropdownButton(
              dropdownHeight: AppSize.s40,
              hint: LocaleKeys.selectDoctor.tr(),
              value: '0',
              dropdownItems: List.generate(
                  doctors.length,
                  (index) => DropdownMenuItem<String>(
                        value: doctors[index].id.toString(),
                        child: TextCustom(
                          text: doctors[index].name,
                          textStyle: getSemiBoldGilroyStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      )),
              onChanged: (onChanged) {
                AvailableTimesCubit.get(context).doctorID =
                    int.parse(onChanged!);

                ServiceCubit.get(context).doctorID = int.parse(onChanged);
              },
              onSave: (String? value) {
                AvailableTimesCubit.get(context).doctorID = int.parse(value!);

                ServiceCubit.get(context).doctorID = int.parse(value);
              },
            ),
          ),
          const RSizedBox.vertical(AppSize.s20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: LocaleKeys.introduction,
                  textStyle: getSemiBoldGilroyStyle(
                    color: Colors.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                const RSizedBox.vertical(AppSize.s10),
                ReadMoreText(
                  description,
                  trimLines: 4,
                  style: getMediumGilroyStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s12,
                  ),
                  colorClickableText: ColorManager.primary,
                  trimMode: TrimMode.Line,
                  moreStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.secondary1,
                    fontSize: FontSize.s12,
                    height: 0.12,
                  ),
                  lessStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.secondary1,
                    fontSize: FontSize.s12,
                    height: 0.12,
                  ),
                  trimCollapsedText: LocaleKeys.readMore.tr(),
                  trimExpandedText: LocaleKeys.collapse.tr(),
                ),
                InkWell(
                  onTap: () {
                    WebViewCubit.get(context).url =
                        'https://ahmedemad007.github.io/DoctorAck_Refund/';
                    navigator(context, Routes.webViewRoute);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p20),
                    child: Row(
                      children: [
                        const SvgPictureCustom(assetsName: IconAssets.privacy),
                        const RSizedBox.horizontal(AppSize.s4),
                        TextCustom(
                          text: LocaleKeys.refundPolicy,
                          textStyle: getMediumGilroyStyle(
                            color: Colors.black,
                            fontSize: FontSize.s14,
                          ),
                        ),
                        const Spacer(),
                        SvgPictureCustom(
                            assetsName: AppConstants.language
                                ? IconAssets.arrowLeftC
                                : IconAssets.arrowRightC),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(AppPadding.p16),
            width: context.width,
            // height: (AppSize.s100 * 1.55).h,
            decoration: const BoxDecoration(color: ColorManager.white1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: LocaleKeys.advice,
                  textStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.32,
                  ),
                ),
                SizedBox(
                  height: AppSize.s10.h,
                ),
                Column(
                  children: List.generate(
                    advice.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: AppPadding.p10),
                      child: Row(
                        children: [
                          const SvgPictureCustom(
                            assetsName: IconAssets.check,
                            color: null,
                          ),
                          SizedBox(
                            width: AppSize.s10.w,
                          ),
                          TextCustom(
                            text: advice[index],
                            textStyle: TextStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s12,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButtonCustom(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: LocaleKeys.close,
                    textColor: ColorManager.grey,
                    fontSize: FontSize.s16,
                    borderColor: ColorManager.grey,
                    colors: Colors.transparent,
                    radius: AppSize.s50.r,
                  ),
                ),
                SizedBox(
                  width: AppSize.s20.w,
                ),
                Expanded(
                  child: BlocProvider.value(
                    value: BlocProvider.of<ServiceCubit>(context),
                    child: BlocBuilder<ServiceCubit, ServiceState>(
                      builder: (context, state) {
                        return ElevatedButtonCustom(
                          onPressed: state is GetServiceSuccessState
                              ? () {
                                  if (ServiceCubit.get(context).doctorID != 0) {
                                    // AvailableTimesCubit.get(context).serviceID = state
                                    //     .serviceEntity.resultEntity.response.id;

                                    ServiceCubit.get(context).serviceID = state
                                        .serviceEntity.resultEntity.response.id;
                                    ServiceCubit.get(context).maxScheduleDays =
                                        state.serviceEntity.resultEntity
                                            .response.maxScheduleDays;
                                    ServiceCubit.get(context).serviceName =
                                        state.serviceEntity.resultEntity
                                            .response.name;
                                    CreateReservationOrderCubit.get(context)
                                            .price =
                                        state.serviceEntity.resultEntity
                                            .response.priceWithDiscount
                                            .toStringAsFixed(0);
                                    navigator(context, Routes.scheduleRoute);
                                  } else {
                                    showToast(context,
                                        message: LocaleKeys.selectDoctor,
                                        type: MessageType.warning);
                                  }
                                }
                              : () {},
                          text: LocaleKeys.schedule,
                          textColor: ColorManager.white,
                          fontSize: FontSize.s16,
                          radius: AppSize.s50.r,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
