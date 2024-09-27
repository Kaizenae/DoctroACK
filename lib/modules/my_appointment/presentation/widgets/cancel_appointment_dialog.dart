import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/select_widget_custom/select_widget_custom.dart';
import 'package:doctor_ack/injection_imports.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/appointment_cubit/appointment_state.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/cancel_change_appointment_cubit/cancel_change_appointment_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../service/presentation/controller/service_state.dart';
import '../../../user/presentation/controllers/users_cubit/users_cubit.dart';

cancelDialog(BuildContext context,
    GetAppointmentSuccessState appointmentSuccessState) async {
  return AwesomeDialog(
    context: context,
    btnOk: BlocProvider.value(
      value: BlocProvider.of<CancelChangeAppointmentsCubit>(context),
      child: BlocConsumer<CancelChangeAppointmentsCubit,
          CancelChangeAppointmentsState>(
        listener: (context, state) {
          if (state is CancelAppointmentSuccessState) {
            showToast(context,
                message: LocaleKeys.toastAppointmentCanceled.tr(),
                type: MessageType.success);
            MyAppointmentsCubit.get(context).getMyAppointment();
            Navigator.popUntil(context, (route) => route.isFirst);

            UsersCubit.get(context).sendNotification();
          } else if (state is CancelAppointmentErrorState) {
            showToast(context, message: state.message, type: MessageType.error);
          } else if (state is CancelAppointmentLoadingState) {
            dialogProgressCustom(context: context);
          }
        },
        builder: (context, state) {
          var changeCubit = CancelChangeAppointmentsCubit.get(context);
          return AnimatedButton(
            pressEvent: () {
              UsersCubit.get(context).title = appointmentSuccessState
                  .appointmentEntity.resultEntity.response.name;
              UsersCubit.get(context).body =
                  'Treatment Reservation ID ${appointmentSuccessState.appointmentEntity.resultEntity.response.id} Canceled';
              UsersCubit.get(context).toToken = appointmentSuccessState
                  .appointmentEntity.resultEntity.response.notification;
              if (CancelChangeAppointmentsCubit.get(context)
                  .reasonController
                  .text
                  .isNotEmpty) {
                changeCubit.reason = changeCubit.reasonController.text;
              }
              changeCubit.cancelAppointment();
            },
            text: LocaleKeys.cancel.tr(),
            buttonTextStyle: getSemiBoldGilroyStyle(
                color: ColorManager.white, fontSize: FontSize.s16, height: 0.9),
          );
        },
      ),
    ),
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.symmetric(
        vertical: AppPadding.p20, horizontal: AppPadding.p12),
    width: double.infinity,
    dialogBackgroundColor: ColorManager.white,
    showCloseIcon: true,
    closeIcon: Container(
      // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
      padding: EdgeInsets.all(AppPadding.p8),
      width: AppSize.s30.h,
      height: AppSize.s30.h,
      decoration: const ShapeDecoration(
        color: ColorManager.white1,
        shape: OvalBorder(),
      ),
      child: const SvgPictureCustom(
        assetsName: IconAssets.close,
        color: null,
      ),
    ),
    dialogBorderRadius: BorderRadius.circular(AppSize.s20.r),
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          DefaultTextStyle(
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s22,
              ),
              textAlign: TextAlign.center,
              child: Material(
                color: ColorManager.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSize.s20.h,
                    ),
                    Center(
                        child: SizedBox(
                      width: (AppSize.s100 * 2.0).w,
                      child: TextCustom(
                        textAlign: TextAlign.center,
                        text: LocaleKeys.cancelAppointment,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                        letterSpacing: -0.36,
                      ),
                    )),
                    SizedBox(
                      height: AppSize.s22.h,
                    ),
                    Center(
                        child: TextCustom(
                      text: LocaleKeys.cancelAppointmentReason,
                      textStyle: getMediumGilroyStyle(
                        color: ColorManager.grey,
                        fontSize: FontSize.s14,
                      ),
                    )),
                    // SizedBox(
                    //   height: AppSize.s20.h,
                    // ),
                    SizedBox(
                      height: AppSize.s100 * 3.45,
                      child: BlocConsumer<ServiceCubit, ServiceState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var cubit = ServiceCubit.get(context);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                SelectWidgetCustom<String>(
                              radius: AppSize.s20.r,
                              selectedColor: ColorManager.secondary1,
                              disabledColor: ColorManager.white1,
                              value: cubit.serviceCancelModel[index]['name'],
                              groupValue: cubit.selectedCancelValue,
                              onChanged: (val) {
                                cubit.selectCancel(val!);
                                CancelChangeAppointmentsCubit.get(context)
                                    .reason = cubit.selectedValue;
                              },
                              index: index,
                              // logo: ImageNetwork.profile1Image,
                              name: cubit.serviceCancelModel[index]['name'],
                            ),
                            itemCount: cubit.serviceCancelModel.length,
                          );
                        },
                      ),
                    ),

                    BlocConsumer<ServiceCubit, ServiceState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var cubit = ServiceCubit.get(context);
                        return Visibility(
                          visible: cubit.selectedCancelValue ==
                              cubit.serviceCancelModel[5]['name'],
                          child: Column(
                            children: [
                              SizedBox(
                                height: AppSize.s16.h,
                              ),
                              SizedBox(
                                height: (AppSize.s100 * 1.1).h,
                                // height: AppSize.s100 * 3,
                                child: TextFormField(
                                  controller:
                                      CancelChangeAppointmentsCubit.get(context)
                                          .reasonController,
                                  decoration: InputDecoration(
                                    hintText: LocaleKeys
                                        .cancelAppointmentReasonHint
                                        .tr(),
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
                                    suffixIconColor:
                                        ColorManager.textFormIconColor,
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
                                          .cancelAppointmentReasonValidation
                                          .tr();
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
                        );
                      },
                    )
                  ],
                ),
              )),
        ],
      ),
    ),
  )..show();
}
