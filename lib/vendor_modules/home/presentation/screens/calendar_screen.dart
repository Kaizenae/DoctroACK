import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/controllers/appointments_cubit/appointments_cubit.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/controllers/appointments_cubit/appointments_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/select_widget_custom/select_widget_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_horizontal.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../../modules/all_services/domain/entities/all_services_entity.dart';
import '../../../../modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import '../../../advanced_reports/presentation/manager/filters_sorts_cubit/filters_sorts_cubit.dart';
import '../../../advanced_reports/presentation/manager/filters_sorts_cubit/filters_sorts_state.dart';
import 'home_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AppointmentsCubit>(context)..getAppointmentsFun(),
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var appointmentsCubit = AppointmentsCubit.get(context);
          return ScaffoldCustom(
            appBarCustom: AppBarCustom(
              text: LocaleKeys.myAppointments,
              centerTitle: false,
              actions: [
                InkWell(
                  onTap: () {
                    bottomSheetCustom(
                      height: 552,
                      context: context,
                      body: Material(
                        borderRadius: BorderRadius.circular(AppSize.s30.r),
                        child:
                            BlocConsumer<FiltersSortsCubit, FiltersSortsState>(
                          listener: (context, filterSortState) {},
                          builder: (context, filterSortState) {
                            var filterSortCubit =
                                FiltersSortsCubit.get(context);
                            return SizedBox(
                              width: context.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p10),
                                child: Column(
                                  children: [
                                    const RSizedBox.vertical(AppSize.s16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              filterSortCubit.clearFilter();
                                            },
                                            child: TextCustom(
                                              text: LocaleKeys.clear,
                                              textStyle: getMediumGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s14),
                                            )),
                                        SizedBox(
                                          height: AppSize.s30,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: TextCustom(
                                              text: LocaleKeys.filter,
                                              fontSize: FontSize.s18,
                                              fontWeight:
                                                  FontWeightManager.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Container(
                                            // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                                            padding:
                                                EdgeInsets.all(AppPadding.p8),
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
                                        )
                                      ],
                                    ),
                                    BlocProvider.value(
                                      value: BlocProvider.of<AllServicesCubit>(
                                          context)
                                        ..getAllServices(),
                                      child: BlocBuilder<AllServicesCubit,
                                          AllServicesState>(
                                        builder: (context, servicesState) {
                                          servicesState
                                                  is GetAllServicesSuccessState
                                              ? servicesState.allClinicsEntity
                                                  .resultEntity.response
                                                  .add(const ResponseEntity(
                                                      id: 0,
                                                      name: LocaleKeys.all,
                                                      clinicServiceEntity:
                                                          ClinicServiceEntity(
                                                              id: 0, name: ''),
                                                      image: '',
                                                      city: '',
                                                      rate: 0.0,
                                                      price: 0.0,
                                                      description: ''))
                                              : null;
                                          return switch (servicesState) {
                                            GetAllServicesSuccessState() =>
                                              ListView.builder(
                                                reverse: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return SelectWidgetCustom<
                                                      int>(
                                                    radius: AppSize.s20.r,
                                                    selectedColor:
                                                        ColorManager.secondary1,
                                                    disabledColor:
                                                        ColorManager.white1,
                                                    index: index,
                                                    value: servicesState
                                                        .allClinicsEntity
                                                        .resultEntity
                                                        .response[index]
                                                        .id,
                                                    groupValue: filterSortCubit
                                                        .categoryId,
                                                    onChanged: (value) =>
                                                        filterSortCubit
                                                            .selectCalendarFilter(
                                                                value!),
                                                    name: servicesState
                                                        .allClinicsEntity
                                                        .resultEntity
                                                        .response[index]
                                                        .name,
                                                  );
                                                },
                                                itemCount: servicesState
                                                    .allClinicsEntity
                                                    .resultEntity
                                                    .response
                                                    .length,
                                              ),
                                            GetAllServicesErrorState() =>
                                              const ErrorsWidget(),
                                            GetAllServicesLoadingState() =>
                                              const ShimmerVertical(),
                                            _ => const ShimmerVertical(),
                                          };
                                        },
                                      ),
                                    ),
                                    const RSizedBox.vertical(AppSize.s24),
                                    TextCustom(
                                      text: LocaleKeys.sortBy,
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                    const RSizedBox.vertical(AppSize.s20),
                                    SizedBox(
                                      // width: context.width/1.1,
                                      height: AppSize.s60,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return SelectWidgetCustom<int>(
                                            radius: AppSize.s30,
                                            selectedColor:
                                                ColorManager.secondary1,
                                            disabledColor: ColorManager.white1,
                                            width: AppSize.s100.w * 1.2,
                                            titleWidth: AppSize.s100.w * 1.8,
                                            index: index,
                                            value: filterSortCubit
                                                .sortModel[index]['id'],
                                            groupValue: filterSortCubit.sortBy,
                                            onChanged: (value) =>
                                                filterSortCubit
                                                    .selectCalendarSort(value!),
                                            name: filterSortCubit
                                                .sortModel[index]['name'],
                                          );
                                        },
                                        itemCount:
                                            filterSortCubit.sortModel.length,
                                      ),
                                    ),
                                    const RSizedBox.vertical(AppSize.s30),
                                    ElevatedButtonCustom(
                                      onPressed: () {
                                        AppointmentsCubit.get(context)
                                                .serviceId =
                                            filterSortCubit.categoryId;
                                        AppointmentsCubit.get(context).filter =
                                            filterSortCubit.sortBy;

                                        AppointmentsCubit.get(context)
                                            .getAppointmentsFun();
                                        Navigator.pop(context);
                                      },
                                      text: LocaleKeys.apply,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: AppSize.s40,
                    height: AppSize.s40,
                    padding: EdgeInsets.all(AppPadding.p10),
                    margin: EdgeInsets.only(right: AppPadding.p10),
                    decoration: ShapeDecoration(
                      color: ColorManager.white1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const SvgPictureCustom(
                      assetsName: IconAssets.filter,
                      color: null,
                    ),
                  ),
                )
              ],
            ),
            body: switch (state) {
              GetAppointmentsSuccessState() => SfCalendar(
                  showNavigationArrow: true,
                  allowViewNavigation: false,

                  onTap: (c) {
                    if (c.targetElement.name == 'calendarCell') {
                      return;
                    }
                    // navigator(context, Routes.servicesRoute);
                    // if(c.resource?.id == '0000'){
                    //   navigator(context, Routes.servicesRoute);
                    // }
                  },
                  // resourceViewSettings: const ResourceViewSettings(
                  //   visibleResourceCount: 2,
                  // ),
                  view: CalendarView.timelineDay,

                  allowedViews: const [
                    CalendarView.timelineDay,
                    CalendarView.timelineWeek,
                    CalendarView.timelineMonth,
                  ],
                  onSelectionChanged: (calendarSelectionDetails) {},
                  firstDayOfWeek: 1,
                  // timeSlotViewSettings: const TimeSlotViewSettings(
                  //   startHour: 9,
                  //   endHour: 18,
                  // ),
                  dataSource: MeetingDataSource(
                      shiftCollection(state, appointmentsCubit),
                      calendarResource(state)),

                  // specialRegions:List.generate(4, (index) =>TimeRegion(
                  //     color: ColorManager.grey,
                  //     textStyle: getMediumGilroyStyle(
                  //         color: ColorManager.white, fontSize: FontSize.s10),
                  //     startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 13, 0, 0),
                  //     endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0, 0),
                  //     text: LocaleKeys.breaks.tr(),
                  //     resourceIds: calendarResource(state).map((e) => e.id).toList(),
                  //     recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
                  //     enablePointerInteraction: false) )

                  // view: CalendarView.,
                ),
              GetAppointmentsErrorState() => const ErrorsWidget(),
              GetAppointmentsLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            },
          );
        },
      ),
    );
  }

  List<Appointment> shiftCollection(
      GetAppointmentsSuccessState state, AppointmentsCubit appointmentsCubit) {
    List<Appointment> shiftCollectionList = <Appointment>[];
    List<Object>? employeeIds = [];
    // for (var calendarResource in calendarResource(state)) {
    //   print(calendarResource.id);
    //   employeeIds .add(calendarResource.id);
    // }

    for (int i = 0;
        i < state.appointmentsEntity.resultEntity.response.length;
        i++) {
      employeeIds = [calendarResource(state)[i].id];

      for (int index = 0;
          index <
              state.appointmentsEntity.resultEntity.response[i].appointments
                  .length;
          index++) {
        shiftCollectionList.add(Appointment(
            startTime: DateTime(
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].startTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .year,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].startTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .month,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].startTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .day,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].startTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .hour,
            ),
            endTime: DateTime(
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].endTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .year,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].endTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .month,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].endTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .day,
              DateTime.parse(state.appointmentsEntity.resultEntity.response[i]
                      .appointments[index].endTime
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', ''))
                  .hour,
            ),
            // startTime:DateTime.parse('${state.appointmentsEntity.resultEntity.response[i..appointments[index].datetoString().replaceAll('(', '').replaceAll(')', '')}T${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].startTime).toString().replaceAll('(', '').replaceAll(')', '')}'),
            // endTime:
            // DateTime.parse('${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].date).toString().replaceAll('(', '').replaceAll(')', '')}T${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].endTime).toString().replaceAll('(', '').replaceAll(')', '')}'),
            subject: state.appointmentsEntity.resultEntity.response[i]
                .appointments[index].name
                .toString(),
            color: appointmentsCubit.colorCollection[Random().nextInt(2)],
            // startTimeZone: 'Gulf Standard Time',
            // endTimeZone: 'Gulf Standard Time',
            resourceIds: employeeIds));
      }
    }
    return shiftCollectionList;
    // return   List.generate(
    //     state.appointmentsEntity.resultEntity.response.length,
    //         (index)
    //     {
    //       employeeIds = [calendarResource(state)[index].id];
    //
    //       return  Appointment(
    //           startTime: DateTime(
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .year,
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .month,
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .day,
    //             int.parse(state.appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].startTime)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', '')
    //                 .split(':')[0]
    //                 .trim()),
    //           ),
    //           endTime: DateTime(
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .year,
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .month,
    //             DateTime.parse(state
    //                 .appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].date)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', ''))
    //                 .day,
    //             int.parse(state.appointmentsEntity.resultEntity.response
    //                 .map((e) => e.appointments[index].endTime)
    //                 .toString()
    //                 .replaceAll('(', '')
    //                 .replaceAll(')', '')
    //                 .split(':')[0]
    //                 .trim()),
    //           ),
    //           // startTime:DateTime.parse('${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].date).toString().replaceAll('(', '').replaceAll(')', '')}T${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].startTime).toString().replaceAll('(', '').replaceAll(')', '')}'),
    //           // endTime:
    //           // DateTime.parse('${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].date).toString().replaceAll('(', '').replaceAll(')', '')}T${state.appointmentsEntity.resultEntity.response.map((e) => e.appointments[index].endTime).toString().replaceAll('(', '').replaceAll(')', '')}'),
    //           subject: state.appointmentsEntity.resultEntity.response
    //               .map((e) => e.appointments[index].name)
    //               .toString(),
    //           color: appointmentsCubit.colorCollection[Random().nextInt(2)],
    //           startTimeZone: 'Egypt Standard Time',
    //           endTimeZone: 'Egypt Standard Time',
    //           resourceIds: employeeIds);
    //     });
  }

  List<CalendarResource> calendarResource(GetAppointmentsSuccessState state) {
    return List.generate(
        state.appointmentsEntity.resultEntity.response.length,
        (index) => CalendarResource(
            id:
                '${state.appointmentsEntity.resultEntity.response[index].serviceId}$index',
            displayName: state
                .appointmentsEntity.resultEntity.response[index].serviceName,
            color: ColorManager.white1,
            // color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
            //     Random().nextInt(255), 1),
            image: CachedNetworkImageProvider(
              state.appointmentsEntity.resultEntity.response[index].serviceLogo,
            )));
  }
}
