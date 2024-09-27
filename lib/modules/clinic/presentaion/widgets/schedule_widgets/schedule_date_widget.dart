import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../service/presentation/controller/service_cubit.dart';
import '../../../../service/presentation/controller/service_state.dart';
import '../../controllers/available_times_cubit/available_times_cubit.dart';
import '../../controllers/create_reservation_order_cubit/create_reservation_order_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ScheduleDateWidget extends StatefulWidget {
  const ScheduleDateWidget({super.key});

  @override
  State<ScheduleDateWidget> createState() => _ScheduleDateWidgetState();
}

class _ScheduleDateWidgetState extends State<ScheduleDateWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        var serviceCubit = ServiceCubit.get(context);
        return EasyDateTimeLine(
          initialDate: _selectedDate,
          onDateChange: (selectedDate) {
            _selectedDate = selectedDate;
            var dateStamp = _selectedDate.toString().split(' ');
            AvailableTimesCubit.get(context).serviceID =
                state is GetServiceSuccessState
                    ? state.serviceEntity.resultEntity.response.id
                    : 0;
            AvailableTimesCubit.get(context).date =
                DateFormat('M/d/y').format(DateTime.parse(dateStamp[0]));
            CreateReservationOrderCubit.get(context).date =
                DateFormat('M/d/y').format(DateTime.parse(dateStamp[0]));

            AvailableTimesCubit.get(context).getAvailableTimes();
          },
          activeColor: ColorManager.primary,
          headerProps: EasyHeaderProps(
            selectedDateStyle: getSemiBoldGilroyStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s18,
            ),
            monthStyle: getSemiBoldGilroyStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s14,
            ),
          ),
          disabledDates: ServiceCubit.get(context)
              .blockDates(serviceCubit.maxScheduleDays),
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
        );
      },
    );
  }
}
