import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/empty.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/appointment_cubit/appointment_cubit.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/my_appointment_cubit/my_appointment_state.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/create_reviews_cubit/create_reviews_cubit.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/create_reviews_cubit/create_reviews_state.dart';
import 'package:doctor_ack/modules/service/presentation/controller/service_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../my_appointment_cubit/my_appointment_cubit.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: LocaleKeys.myAppointments,
          isNull: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocProvider.value(
                value: BlocProvider.of<MyAppointmentsCubit>(context)
                  ..getMyAppointment(),
                child: BlocBuilder<MyAppointmentsCubit, MyAppointmentsState>(
                  builder: (context, state) {
                    var myAppointmentsCubit = MyAppointmentsCubit.get(context);
                    return TabBarCustom(radius: AppSize.s24.r, myTabs: [
                      Tab(
                        text: LocaleKeys.upcoming.tr(),
                      ),
                      Tab(
                        text: LocaleKeys.past.tr(),
                      ),
                    ], widgets: [
                      SmartRefresher(
                        controller: myAppointmentsCubit.refreshController,
                        onRefresh: () => myAppointmentsCubit.getMyAppointment(),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          runSpacing: AppSize.s12,
                          spacing: AppSize.s20,
                          children: switch (state) {
                            GetMyAppointmentSuccessState() => state
                                    .myAppointmentEntity
                                    .resultEntity
                                    .upComingAppointments
                                    .isNotEmpty
                                ? List.generate(
                                    state.myAppointmentEntity.resultEntity
                                        .upComingAppointments.length,
                                    (index) => MyAppointmentsCard(
                                          city: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .city,
                                          clinicName: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .clinicName,
                                          rate: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .rate,
                                          name: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .name,
                                          id: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .id,
                                          advice: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .advice,
                                          date: DateFormat('dd-MM-y').format(
                                              DateTime.parse(state
                                                  .myAppointmentEntity
                                                  .resultEntity
                                                  .upComingAppointments[index]
                                                  .date)),
                                          image: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .image,
                                          index: index,
                                          numReviews: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .upComingAppointments[index]
                                              .numReviews,
                                          past: false,
                                        ))
                                : [const Center(child: EmptyWidget(title: ''))],
                            GetMyAppointmentErrorState() => [
                                ErrorsWidget(
                                  onPress: () =>
                                      myAppointmentsCubit.getMyAppointment(),
                                  text: state.message,
                                )
                              ],
                            GetMyAppointmentLoadingState() => List.generate(
                                4,
                                (index) => const ShimmerCustom(
                                      child: MyAppointmentsCard(
                                        city: '',
                                        clinicName: '',
                                        rate: 0.0,
                                        name: '',
                                        id: 0,
                                        advice: [],
                                        date: '',
                                        image: '',
                                        index: 0,
                                        numReviews: 0,
                                        past: false,
                                      ),
                                    )),
                            _ => List.generate(
                                4,
                                (index) => const ShimmerCustom(
                                      child: MyAppointmentsCard(
                                        city: '',
                                        clinicName: '',
                                        rate: 0.0,
                                        name: '',
                                        id: 0,
                                        advice: [],
                                        date: '',
                                        image: '',
                                        index: 0,
                                        numReviews: 0,
                                        past: false,
                                      ),
                                    )),
                          },
                        ),
                      ),
                      SmartRefresher(
                        controller: myAppointmentsCubit.refreshPastController,
                        onRefresh: () => myAppointmentsCubit.getMyAppointment(),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          runSpacing: AppSize.s12,
                          spacing: AppSize.s20,
                          children: switch (state) {
                            GetMyAppointmentSuccessState() => state
                                    .myAppointmentEntity
                                    .resultEntity
                                    .pastAppointments
                                    .isNotEmpty
                                ? List.generate(
                                    state.myAppointmentEntity.resultEntity
                                        .pastAppointments.length,
                                    (index) => MyAppointmentsCard(
                                          serviceId: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .serviceId,
                                          city: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .city,
                                          clinicName: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .clinicName,
                                          rate: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .rate,
                                          isRated: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .isRated,
                                          isReviewed: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .isReviewed,
                                          name: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .name,
                                          id: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .id,
                                          advice: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .advice,
                                          date: DateFormat('dd-MM-y').format(
                                              DateTime.parse(state
                                                  .myAppointmentEntity
                                                  .resultEntity
                                                  .pastAppointments[index]
                                                  .date)),
                                          image: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .image,
                                          index: index,
                                          numReviews: state
                                              .myAppointmentEntity
                                              .resultEntity
                                              .pastAppointments[index]
                                              .numReviews,
                                          past: true,
                                        ))
                                : [const EmptyWidget(title: '')],
                            GetMyAppointmentErrorState() => [
                                ErrorsWidget(
                                  onPress: () =>
                                      myAppointmentsCubit.getMyAppointment(),
                                  text: state.message,
                                )
                              ],
                            GetMyAppointmentLoadingState() => List.generate(
                                4,
                                (index) => const ShimmerCustom(
                                      child: MyAppointmentsCard(
                                        city: '',
                                        clinicName: '',
                                        rate: 0.0,
                                        name: '',
                                        id: 0,
                                        advice: [],
                                        date: '',
                                        image: '',
                                        index: 0,
                                        numReviews: 0,
                                        past: false,
                                      ),
                                    )),
                            _ => [const SizedBox()],
                          },
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class MyAppointmentsCard extends StatelessWidget {
  final bool past;
  final int id;
  final String name;
  final String clinicName;
  final String image;
  final String date;
  final String city;
  final double rate;
  final bool? isRated;
  final bool? isReviewed;
  final int? serviceId;
  final int numReviews;
  final int index;
  final List<String> advice;

  const MyAppointmentsCard({
    super.key,
    required this.past,
    required this.id,
    required this.name,
    required this.clinicName,
    required this.image,
    required this.date,
    required this.numReviews,
    required this.city,
    required this.rate,
    this.isReviewed = false,
    this.isRated = false,
    this.serviceId = 0,
    required this.advice,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p16),
      child: FadeIn(
        // duration: const Duration(milliseconds: 250),

        child: Container(
          height: (AppSize.s100 * 2.4).h,
          width: context.tablet ? (AppSize.s100 * 1.61).w : context.width / 2.4,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s20.r)),
          child: InkWell(
            onTap: () {
              AppointmentCubit.get(context).id = id;
              ServiceCubit.get(context).buttonName =
                  !past ? LocaleKeys.cancelAppointment : LocaleKeys.reBook;
              navigator(context, Routes.myAppointmentServiceRoute);
            },
            child: Stack(
              children: [
                Positioned(
                  top: AppSize.s16,
                  child: Container(
                    height: (AppSize.s100 * 1.76).h,
                    width: (AppSize.s100 * 1.6).w,
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? ColorManager.pink
                            : ColorManager.yellowL,
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
                        Positioned(
                          bottom: AppSize.s28,
                          left: AppSize.s38,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(AppSize.s20.r),
                                bottomRight: Radius.circular(AppSize.s20.r)),
                            child: CachedNetworkImageCustom(
                                height: (AppSize.s100 * 1).h,
                                width: AppSize.s100.w,
                                boxFit: BoxFit.cover,
                                boarder: AppSize.s0,
                                url: image),
                          ),
                        ),
                        Positioned(
                          top: AppSize.s16,
                          left: AppSize.s10,
                          child: TextCustom(
                            textStyle: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: FontSize.s14,
                              fontWeight: FontWeightManager.regular,
                            ),
                            text: name,
                          ),
                        ),
                        Positioned(
                          top: AppSize.s14,
                          right: AppSize.s8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p4,
                                vertical: AppPadding.p2),
                            width: AppSize.s24.h,
                            height: AppSize.s24.h,
                            decoration: ShapeDecoration(
                              color: index.isEven
                                  ? ColorManager.pink1
                                  : ColorManager.caffe2,
                              shape: const OvalBorder(),
                            ),
                            child: InkWell(
                              onTap: () {
                                bottomSheetCustom(
                                  height: AppSize.s100.h * 4,
                                  context: context,
                                  body: SummaryCardWidget(
                                    advice: advice,
                                    name: name,
                                    clinicName: clinicName,
                                  ),
                                );
                              },
                              child: SvgPictureCustom(
                                assetsName: IconAssets.sammary,
                                color: null,
                                height: AppSize.s16.h,
                                width: AppSize.s16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  // bottom:-10,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(AppPadding.p6),
                    width: (AppSize.s100 * 1.35).w,
                    height: past ? AppSize.s80.h : AppSize.s56.h,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(AppSize.s10.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: AppSize.s24.w,
                              height: AppSize.s24.w,
                              padding: EdgeInsets.all(AppPadding.p6),
                              decoration: ShapeDecoration(
                                color: index.isEven
                                    ? ColorManager.pink1
                                    : ColorManager.caffe2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s50.r),
                                ),
                              ),
                              child: const SvgPictureCustom(
                                assetsName: IconAssets.service1,
                                color: ColorManager.serviceIconColor,
                              ),
                            ),
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
                                    text: clinicName,
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
                                      text: city,
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
                            ),
                          ],
                        ),
                        Visibility(
                          visible: past && isRated!,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: AppSize.s12.h,
                              ),
                              Row(
                                children: [
                                  SvgPictureCustom(
                                    assetsName: IconAssets.star2,
                                    color: null,
                                    height: AppSize.s16.h,
                                    width: AppSize.s16.w,
                                  ),
                                  SizedBox(
                                    width: AppSize.s4.w,
                                  ),
                                  TextCustom(
                                    text: rate.toStringAsFixed(1),
                                    textStyle: getMediumGilroyStyle(
                                        color: ColorManager.grey1,
                                        fontSize: FontSize.s12),
                                  )
                                ],
                              ),
                              const SvgPictureCustom(
                                assetsName: IconAssets.divider,
                                color: null,
                              ),
                              Row(
                                children: [
                                  SvgPictureCustom(
                                    assetsName: IconAssets.message,
                                    color: null,
                                    height: AppSize.s16.h,
                                    width: AppSize.s16.w,
                                  ),
                                  SizedBox(
                                    width: AppSize.s4.w,
                                  ),
                                  TextCustom(
                                    text: numReviews.toString(),
                                    textStyle: getMediumGilroyStyle(
                                        color: ColorManager.grey1,
                                        fontSize: FontSize.s12),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: past && !isRated!,
                            child: InkWell(
                              onTap: () {
                                CreateReviewsCubit.get(context).serviceID =
                                    serviceId!;
                                dialog(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: AppPadding.p8),
                                alignment: Alignment.center,
                                width: AppSize.s70.w,
                                height: AppSize.s20.h,
                                decoration: ShapeDecoration(
                                  color: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10.r),
                                  ),
                                ),
                                child: TextCustom(
                                  text: LocaleKeys.rateUs,
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s12),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppSize.s2,
                  right: AppSize.s0,
                  child: Container(
                    width: AppSize.s90.w,
                    height: AppSize.s24.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s24.r),
                      ),
                    ),
                    child: TextCustom(
                      text: date,
                      textStyle: getSemiBoldGilroyStyle(
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryCardWidget extends StatelessWidget {
  final List<String> advice;
  final String name;
  final String clinicName;
  const SummaryCardWidget({
    super.key,
    required this.advice,
    required this.name,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextStyle(
            style: const TextStyle(
              color: CupertinoColors.black,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.center,
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: TextCustom(
                    text: LocaleKeys.summary,
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.bold,
                  )),
                  SizedBox(
                    height: AppSize.s16.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(AppPadding.p12),
                    height: AppSize.s70.h,
                    decoration: ShapeDecoration(
                      color: ColorManager.white1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPictureCustom(
                          assetsName: IconAssets.service1,
                          color: ColorManager.brown,
                          height: AppSize.s30.h,
                          width: AppSize.s30.h,
                        ),
                        RSizedBox.horizontal(AppSize.s24.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text: name,
                              textStyle: getMediumGilroyStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16),
                            ),
                            RSizedBox.vertical(AppSize.s4.h),
                            TextCustom(
                              text: clinicName,
                              textStyle: getRegularGilroyStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s12),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s16.h,
                  ),
                  TextCustom(
                    text: LocaleKeys.advice,
                    textStyle: getSemiBoldGilroyStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                  ),
                  SizedBox(
                    height: AppSize.s16.h,
                  ),
                  Column(
                    children: advice.isNotEmpty
                        ? List.generate(
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
                          )
                        : [],
                  )
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.only(bottom: AppPadding.p20),
          child: ElevatedButtonCustom(
            width: (AppSize.s100 * 3).w,
            radius: AppSize.s50.r,
            text: LocaleKeys.acknowledge,
            textStyle: getSemiBoldGilroyStyle(
                color: ColorManager.white, fontSize: FontSize.s16),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}

dialog(BuildContext context) async {
  return await AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    title: '',
    width: double.infinity,
    dialogBackgroundColor: ColorManager.white,
    desc: '',
    showCloseIcon: true,
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<CreateReviewsCubit, CreateReviewsState>(
        listener: (context, state) {
          if (state is CreateReviewsSuccessState) {
            showToast(context,
                message: LocaleKeys.toastReservation.tr(),
                type: MessageType.success);
            MyAppointmentsCubit.get(context).getMyAppointment();
            Navigator.pop(context);
          } else if (state is CreateReviewsErrorState) {
            showToast(context, message: state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          var cubit = CreateReviewsCubit.get(context);
          return Column(
            children: [
              DefaultTextStyle(
                  style: const TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p12),
                    child: Material(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: TextCustom(
                            text: LocaleKeys.writeReview,
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          )),
                          SizedBox(
                            height: AppSize.s30.h,
                          ),
                          Center(
                              child: TextCustom(
                            text: LocaleKeys.reviewDescription,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s14,
                            ),
                          )),
                          SizedBox(
                            height: AppSize.s16.h,
                          ),
                          Center(
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              unratedColor: ColorManager.white1,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) =>
                                  const SvgPictureCustom(
                                assetsName: IconAssets.star2,
                                color: ColorManager.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                cubit.rate =
                                    rating.toString().replaceAll(".0", "");
                              },
                            ),
                          ),
                          SizedBox(
                            height: AppSize.s16.h,
                          ),
                          SizedBox(
                            // height: AppSize.s100 * 3,
                            child: TextFormField(
                              controller: cubit.note,
                              decoration: InputDecoration(
                                hintText: LocaleKeys.writeYourComment.tr(),
                                hintStyle: getLightGilroyStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12),
                                filled: true,
                                fillColor: ColorManager.textFormColor,
                                isDense: true,
                                //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  borderSide: const BorderSide(
                                    color: ColorManager.textFormColor,
                                    width: AppSize.s1_5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  borderSide: const BorderSide(
                                    color: ColorManager.textFormColor,
                                    width: AppSize.s1_5,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p16,
                                  horizontal: AppPadding.p16,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  borderSide: const BorderSide(
                                    color: ColorManager.textFormColor,
                                    width: AppSize.s1_5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: AppSize.s1_5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s8),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                suffixIconColor: ColorManager.textFormIconColor,
                                focusColor: ColorManager.textFormColor,

                                labelStyle: const TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: AppSize.s16,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: AppSize.s16,
                                ),
                              ),
                              validator: (validate) {
                                if (validate!.isEmpty) {
                                  return LocaleKeys
                                      .cancelAppointmentReasonValidation;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: AppSize.s16.h,
              ),
              state is CreateReviewsLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButtonCustom(
                      radius: AppSize.s50.r,
                      text: LocaleKeys.save,
                      textStyle: getSemiBoldGilroyStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s16,
                          height: 0.9),
                      onPressed: () {
                        cubit.createReviews();
                        // Navigator.pop(context);
                      },
                    )
            ],
          );
        },
      ),
    ),
  ).show();
}
