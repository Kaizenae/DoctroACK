import 'dart:ffi';

import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/refund_widget.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/appointment_cubit/appointment_cubit.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/appointment_cubit/appointment_state.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/cancel_change_appointment_cubit/cancel_change_appointment_cubit.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/cancel_change_appointment_cubit/cancel_change_appointment_state.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/my_appointment_cubit/my_appointment_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import '../../../service/presentation/controller/service_cubit.dart';
import '../../../service/presentation/controller/service_state.dart';
import 'cancel_appointment_dialog.dart';
import 'change_appointment_dialog.dart';

class AppointmentServiceScreen extends StatefulWidget {
  const AppointmentServiceScreen({super.key});

  @override
  State<AppointmentServiceScreen> createState() =>
      _AppointmentServiceScreenState();
}

class _AppointmentServiceScreenState extends State<AppointmentServiceScreen> {
  late DateTime _selectedDate;
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocProvider.value(
            value: BlocProvider.of<AppointmentCubit>(context)
              ..getMyAppointment(),
            child: BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                var appointmentCubit = AppointmentCubit.get(context);
                return switch (state) {
                  GetAppointmentSuccessState() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  url: state.appointmentEntity.resultEntity
                                      .response.icon,
                                  width: (AppSize.s100 * 2.2),
                                  height: (AppSize.s100 * 1.6).h,
                                  boxFit: BoxFit.fill,
                                  // boarder: AppSize.s24.r,
                                ),
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
                                        // const Spacer(),
                                        // InkWell(
                                        //     onTap: () {
                                        //       Navigator.pop(context);
                                        //     },
                                        //     child: SvgPictureCustom(
                                        //       assetsName: IconAssets.share,
                                        //       color: null,
                                        //       height: AppSize.s34.h,
                                        //       width: AppSize.s34.h,
                                        //     )),
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
                                      ReviewsCubit.get(context).isClinic =
                                          false;
                                      ReviewsCubit.get(context).clinicID = state
                                          .appointmentEntity
                                          .resultEntity
                                          .response
                                          .serviceId;
                                      ReviewsCubit.get(context).clinicRate =
                                          state.appointmentEntity.resultEntity
                                              .response.rate
                                              .toStringAsFixed(1);
                                      ReviewsCubit.get(context).clinicName =
                                          state.appointmentEntity.resultEntity
                                              .response.name;
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
                                          textStyle: getRegularGilroyStyle(
                                            fontSize: FontSize.s20,
                                            color: ColorManager.white,
                                          ),
                                          text: state.appointmentEntity
                                              .resultEntity.response.rate
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: (AppSize.s100 * 2).w,
                                    child: TextCustom(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textStyle: getMediumGilroyStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s18,
                                      ),
                                      text: state.appointmentEntity.resultEntity
                                          .response.name,
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
                                        text: state.appointmentEntity
                                            .resultEntity.response.city,
                                        textStyle: getRegularGilroyStyle(
                                          fontSize: FontSize.s12,
                                          color: ColorManager.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s20.h,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: state.appointmentEntity.resultEntity
                                    .response.doctor,
                                textStyle: getMediumGilroyStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              TextCustom(
                                text: state.appointmentEntity.resultEntity
                                    .response.aboutDoctor,
                                textStyle: getMediumGilroyStyle(
                                  color: ColorManager.grey,
                                  fontSize: FontSize.s12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p16),
                          child: const RefundWidget(),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextCustom(
                                    text: LocaleKeys.appointmentDate,
                                    textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                  Visibility(
                                    visible: DateTime.now()
                                            .difference(DateTime.parse(state
                                                .appointmentEntity
                                                .resultEntity
                                                .response
                                                .appointmentDate))
                                            .inHours <
                                        0,
                                    child: BlocProvider.value(
                                      value: BlocProvider.of<
                                              CancelChangeAppointmentsCubit>(
                                          context),
                                      child: BlocConsumer<
                                          CancelChangeAppointmentsCubit,
                                          CancelChangeAppointmentsState>(
                                        listener: (context, changeState) {
                                          if (changeState
                                              is ChangeAppointmentSuccessState) {
                                            appointmentCubit.getMyAppointment();
                                            MyAppointmentsCubit.get(context)
                                                .getMyAppointment();
                                            showToast(context,
                                                message: LocaleKeys
                                                    .toastAppointmentChanged
                                                    .tr(),
                                                type: MessageType.success);
                                            Navigator.pop(context);
                                          }
                                        },
                                        builder: (context, changeState) {
                                          var changeCubit =
                                              CancelChangeAppointmentsCubit.get(
                                                  context);

                                          return TextButton(
                                            onPressed: () {
                                              changeAppointmentDialog(
                                                  context,
                                                  state,
                                                  changeCubit,
                                                  _selectedDate);
                                            },
                                            child: TextCustom(
                                              text: LocaleKeys.change,
                                              textStyle: getSemiBoldGilroyStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextCustom(
                                    text: DateFormat.yMMMMEEEEd().format(
                                        DateTime.parse(state
                                            .appointmentEntity
                                            .resultEntity
                                            .response
                                            .appointmentDate)),
                                    textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  TextCustom(
                                    text:
                                        "${DateTime.parse(state.appointmentEntity.resultEntity.response.appointmentDate).toString().split(" ")[1].split(":")[0].toString()}:${DateTime.parse(state.appointmentEntity.resultEntity.response.appointmentDate).toString().split(" ")[1].split(":")[1].toString()}",
                                    textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSize.s20.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(AppPadding.p16),
                          width: context.width,
                          // height: (AppSize.s100 * 1.55).h,
                          decoration:
                              const BoxDecoration(color: ColorManager.white1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: LocaleKeys.advice,
                                textStyle: getMediumGilroyStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              SizedBox(
                                height: AppSize.s10.h,
                              ),
                              Column(
                                children: state.appointmentEntity.resultEntity
                                        .response.advice.isNotEmpty
                                    ? List.generate(
                                        state.appointmentEntity.resultEntity
                                            .response.advice.length,
                                        (index) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: AppPadding.p10),
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
                                                text: state
                                                    .appointmentEntity
                                                    .resultEntity
                                                    .response
                                                    .advice[index],
                                                textStyle:
                                                    getRegularGilroyStyle(
                                                  color: ColorManager.grey,
                                                  fontSize: FontSize.s12,
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
                        ),
                        SizedBox(
                          height: AppSize.s20.h,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p16),
                          child: BlocConsumer<ServiceCubit, ServiceState>(
                            listener: (context, serviceState) {},
                            builder: (context, serviceState) {
                              var cubit = ServiceCubit.get(context);
                              return ElevatedButtonCustom(
                                onPressed: cubit.buttonName == LocaleKeys.reBook
                                    ? () {
                                        cubit.serviceName = state
                                            .appointmentEntity
                                            .resultEntity
                                            .response
                                            .service;
                                        cubit.serviceID = state
                                            .appointmentEntity
                                            .resultEntity
                                            .response
                                            .serviceId;

                                        navigator(
                                            context, Routes.serviceClinicRoute);
                                      }
                                    : () {
                                        CancelChangeAppointmentsCubit.get(
                                                    context)
                                                .id =
                                            state.appointmentEntity.resultEntity
                                                .response.id;
                                        cancelDialog(context, state);
                                      },
                                text: cubit.buttonName,
                                textStyle: getMediumGilroyStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16,
                                ),
                                radius: AppSize.s50.r,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  GetAppointmentErrorState() => ErrorsWidget(
                      onPress: () => appointmentCubit.getMyAppointment()),
                  GetAppointmentLoadingState() => ShimmerCustom(
                        child: Container(
                      color: ColorManager.lightGrey,
                      height: AppSize.s100 * 3,
                    )),
                  _ => ShimmerCustom(
                        child: Container(
                      color: ColorManager.lightGrey,
                      height: AppSize.s100 * 3,
                    )),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
