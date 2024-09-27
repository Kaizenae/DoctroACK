import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/component.dart';
import '../../controllers/available_times_cubit/available_times_cubit.dart';
import '../../controllers/available_times_cubit/available_times_state.dart';
import '../../controllers/create_reservation_order_cubit/create_reservation_order_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ScheduleTimeWidget extends StatelessWidget {
  const ScheduleTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AvailableTimesCubit>(context)..getAvailableTimes(),
      child: BlocConsumer<AvailableTimesCubit, AvailableTimesState>(
        listener: (context, state) {
          if (state is GetAvailableTimesErrorState) {
            showToast(
              context,
              message: LocaleKeys.toastValidDate.tr(),
              // color: ColorManager.primary,
              type: MessageType.error,
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
                    state.availableTimesEntity.resultEntity.response.length,
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
                    state.availableTimesEntity.resultEntity.response.length,
                    (index) => state.availableTimesEntity.resultEntity
                        .response[index].start)
                : const [],
            defaultSelected: null,
            // height: AppSize.s40,
            radioButtonValue: (value) {
              CreateReservationOrderCubit.get(context).start =
                  availableCubit.convert24HourFormat(value);
            },
            selectedColor: ColorManager.primary,
          );
        },
      ),
    );
  }
}
