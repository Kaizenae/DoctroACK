import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/available_times_cubit/available_times_cubit.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/appointment_cubit/appointment_state.dart';
import 'package:doctor_ack/modules/my_appointment/presentation/controllers/cancel_change_appointment_cubit/cancel_change_appointment_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../clinic/presentaion/controllers/available_times_cubit/available_times_state.dart';
import '../../../service/presentation/controller/service_cubit.dart';
import '../../../user/presentation/controllers/users_cubit/users_cubit.dart';

changeAppointmentDialog(BuildContext context, GetAppointmentSuccessState state,
    CancelChangeAppointmentsCubit changeCubit, DateTime selectedDate) {
  dialogCustom(
      context: context,
      okButtonName: LocaleKeys.save.tr(),
      body: StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            TextCustom(
              text: LocaleKeys.appointmentDate,
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.semiBold,
            ),
            EasyDateTimeLine(
              initialDate: selectedDate,
              onDateChange: (selectedDate) {
                selectedDate = selectedDate;
                var dateStamp = selectedDate.toString().split(' ');
                AvailableTimesCubit.get(context).serviceID =
                    state.appointmentEntity.resultEntity.response.serviceId;
                AvailableTimesCubit.get(context).date =
                    DateFormat('M/d/y').format(DateTime.parse(dateStamp[0]));
                changeCubit.date =
                    DateFormat('M/d/y').format(DateTime.parse(dateStamp[0]));

                AvailableTimesCubit.get(context).getAvailableTimes();
                // print(CreateReservationOrderCubit.get(context).date);
              },
              activeColor: ColorManager.primary,
              headerProps: EasyHeaderProps(
                selectedDateStyle: TextStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                  fontFamily: 'Gilroy-SemiBold',
                  fontWeight: FontWeightManager.semiBold,
                  height: 0,
                  letterSpacing: -0.28,
                ),
                monthStyle: TextStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s14,
                  fontFamily: 'Gilroy-SemiBold',
                  fontWeight: FontWeightManager.semiBold,
                  height: 0,
                  letterSpacing: -0.28,
                ),
              ),
              disabledDates: ServiceCubit.get(context).blockDates(20),
              dayProps: EasyDayProps(
                inactiveDayStyle: DayStyle(
                  borderRadius: AppSize.s20.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20.r),
                    color: ColorManager.white1,
                  ),
                ),
                disabledDayStyle: DayStyle(
                    decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorManager.divider),
                  borderRadius: BorderRadius.circular(AppSize.s20.r),
                )),
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: ColorManager.white1,
                activeDayStyle: DayStyle(borderRadius: AppSize.s20.r),
              ),
              locale: AppConstants.language ? 'ar' : 'en',
            ),
            SizedBox(
              height: AppSize.s20.h,
            ),
            Align(
              alignment: AppConstants.language
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: TextCustom(
                text: LocaleKeys.availableTimes,
                textStyle: TextStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                  fontFamily: 'Gilroy-SemiBold',
                  fontWeight: FontWeightManager.semiBold,
                  height: 0,
                  letterSpacing: -0.28,
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s14.h,
            ),
            BlocProvider.value(
              value: BlocProvider.of<AvailableTimesCubit>(context)
                ..getAvailableTimes(),
              child: BlocConsumer<AvailableTimesCubit, AvailableTimesState>(
                listener: (context, state) {
                  if (state is GetAvailableTimesErrorState) {
                    showToast(
                      context,
                      message: LocaleKeys.toastValidDate.tr(),
                      // color: ColorManager.primary,
                      type: MessageType.warning,
                    );
                  }
                },
                buildWhen: (previous, current) {
                  var cubit = AvailableTimesCubit.get(context);

                  return cubit.date.isNotEmpty;
                },
                builder: (context, state) {
                  var availableCubit = AvailableTimesCubit.get(context);
                  return CustomRadioButton(
                    horizontal: false,
                    enableShape: true,
                    elevation: 0,
                    // radius: AppSize.s10.r,
                    // shapeRadius: AppSize.s10.r,
                    autoWidth: true,
                    // width: AppSize.s100*1.63,
                    wrapAlignment: WrapAlignment.spaceBetween,
                    enableButtonWrap: true,
                    disabledColor: ColorManager.white,

                    unSelectedBorderColor: ColorManager.divider,
                    customShape: const StadiumBorder(
                        side: BorderSide(
                      color: ColorManager.divider,
                    )),
                    spacing: AppPadding.p16,
                    margin: EdgeInsets.only(bottom: AppPadding.p16),
                    unSelectedColor: ColorManager.white,
                    // disabledValues: const [2],
                    buttonLables: state is GetAvailableTimesSuccessState
                        ? List.generate(
                            state.availableTimesEntity.resultEntity.response
                                .length,
                            (index) =>
                                '${availableCubit.convert24To12HourFormat(state.availableTimesEntity.resultEntity.response[index].start)} - ${availableCubit.convert24To12HourFormat(state.availableTimesEntity.resultEntity.response[index].end)}')
                        : const [],
                    buttonTextStyle: ButtonTextStyle(
                        unSelectedColor: ColorManager.primary,
                        disabledColor: ColorManager.divider,
                        textStyle: TextStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s12,
                          fontFamily: 'Gilroy-SemiBold',
                          fontWeight: FontWeightManager.semiBold,
                          height: 0,
                          letterSpacing: -0.24,
                        ),
                        selectedColor: ColorManager.white),
                    buttonValues: state is GetAvailableTimesSuccessState
                        ? List.generate(
                            state.availableTimesEntity.resultEntity.response
                                .length,
                            (index) => state.availableTimesEntity.resultEntity
                                .response[index].start)
                        : const [],
                    defaultSelected: null,
                    // height: AppSize.s40,
                    radioButtonValue: (value) {
                      changeCubit.time =
                          availableCubit.convert24HourFormat(value);
                    },
                    selectedColor: ColorManager.primary,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      pressEventOk: () {
        changeCubit.id = state.appointmentEntity.resultEntity.response.id;

        changeCubit.changeAppointment();
        UsersCubit.get(context).title =
            state.appointmentEntity.resultEntity.response.name;
        UsersCubit.get(context).body =
            'Treatment Reservation ID ${state.appointmentEntity.resultEntity.response.id} change time to ${changeCubit.time}';
        UsersCubit.get(context).toToken =
            state.appointmentEntity.resultEntity.response.notification;
        changeCubit.changeAppointment();
        UsersCubit.get(context).sendNotification();
        Navigator.pop(context);
      });
}
