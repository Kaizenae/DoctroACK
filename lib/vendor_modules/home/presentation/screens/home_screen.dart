import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/controllers/sales_cubit/sales_cubit.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/controllers/sales_cubit/sales_state.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/controllers/clinic_profile_cubit/clinic_profile_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../../finances/presentation/manager/finances_cubit/finances_cubit.dart';
import '../../../finances/presentation/manager/finances_cubit/finances_state.dart';
import '../controllers/appointments_cubit/appointments_cubit.dart';
import '../controllers/appointments_cubit/appointments_state.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> shiftCollection,
      List<CalendarResource> employeeCalendarResource) {
    appointments = shiftCollection;
    resources = employeeCalendarResource;
  }
}

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              BlocBuilder<VendorClinicCubit, ClinicProfileState>(
                builder: (context, state) {
                  return switch (state) {
                    ClinicProfileSuccessState() => SizedBox(
                        child: Row(
                          children: [
                            state.clinicProfileEntity.resultEntity.response
                                    .image.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(AppPadding.p10),
                                    width: AppSize.s40,
                                    height: AppSize.s40,
                                    decoration: ShapeDecoration(
                                      color: ColorManager.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const SvgPictureCustom(
                                      assetsName: IconAssets.service1,
                                      // boxFit: BoxFit.scaleDown,
                                      height: AppSize.s20,
                                      color: ColorManager.secondary1,
                                    ),
                                  )
                                : CachedNetworkImageCustom(
                                    boarder: AppSize.s30,
                                    width: AppSize.s40,
                                    height: AppSize.s40,
                                    url: state.clinicProfileEntity.resultEntity
                                        .response.image),
                            const RSizedBox.horizontal(AppSize.s16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: LocaleKeys.dashboard,
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.bold,
                                  letterSpacing: -0.30,
                                  color: ColorManager.primary,
                                ),
                                TextCustom(
                                  text: state.clinicProfileEntity.resultEntity
                                      .response.name,
                                  textStyle: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s14,
                                    fontFamily: 'SF Pro Text',
                                    fontWeight: FontWeightManager.regular,
                                    height: 0,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: AppSize.s40,
                              height: AppSize.s40,
                              decoration: ShapeDecoration(
                                color: ColorManager.white1,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s20.r),
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    navigator(
                                        context, Routes.notificationsRoute);
                                  },
                                  icon: const SvgPictureCustom(
                                      assetsName: IconAssets.notificationIcon)),
                            ),
                          ],
                        ),
                      ),
                    ClinicProfileErrorState() => const SizedBox(),
                    ClinicProfileLoadingState() => ShimmerCustom(
                          child: SizedBox(
                        height: AppSize.s44,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppPadding.p10),
                              width: AppSize.s40,
                              height: AppSize.s40,
                              decoration: ShapeDecoration(
                                color: ColorManager.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const SvgPictureCustom(
                                assetsName: IconAssets.service1,
                                // boxFit: BoxFit.scaleDown,
                                height: AppSize.s20,
                                color: ColorManager.secondary1,
                              ),
                            ),
                            const RSizedBox.horizontal(AppSize.s16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: LocaleKeys.dashboard,
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.bold,
                                  letterSpacing: -0.30,
                                  color: ColorManager.primary,
                                ),
                                TextCustom(
                                  text: 'Medical Clinic',
                                  textStyle: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s14,
                                    fontFamily: 'SF Pro Text',
                                    fontWeight: FontWeightManager.regular,
                                    height: 0,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: AppSize.s40,
                              height: AppSize.s40,
                              decoration: ShapeDecoration(
                                color: ColorManager.white1,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s20.r),
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    navigator(
                                        context, Routes.notificationsRoute);
                                  },
                                  icon: const SvgPictureCustom(
                                      assetsName: IconAssets.notificationIcon)),
                            ),
                          ],
                        ),
                      )),
                    _ => ShimmerCustom(
                          child: SizedBox(
                        height: AppSize.s44,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppPadding.p10),
                              width: AppSize.s40,
                              height: AppSize.s40,
                              decoration: ShapeDecoration(
                                color: ColorManager.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const SvgPictureCustom(
                                assetsName: IconAssets.service1,
                                // boxFit: BoxFit.scaleDown,
                                height: AppSize.s20,
                                color: ColorManager.secondary1,
                              ),
                            ),
                            const RSizedBox.horizontal(AppSize.s16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: LocaleKeys.dashboard,
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWeightManager.bold,
                                  letterSpacing: -0.30,
                                  color: ColorManager.primary,
                                ),
                                TextCustom(
                                  text: 'Medical Clinic',
                                  textStyle: TextStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s14,
                                    fontFamily: 'SF Pro Text',
                                    fontWeight: FontWeightManager.regular,
                                    height: 0,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: AppSize.s40,
                              height: AppSize.s40,
                              decoration: ShapeDecoration(
                                color: ColorManager.white1,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s20.r),
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    navigator(
                                        context, Routes.notificationsRoute);
                                  },
                                  icon: const SvgPictureCustom(
                                      assetsName: IconAssets.notificationIcon)),
                            ),
                          ],
                        ),
                      )),
                  };
                },
              ),
              const RSizedBox.vertical(AppSize.s30),
              Visibility(
                visible: AppConstants.role == 'admin' ||
                    AppConstants.type == 'clinic',
                child: SlideInLeft(
                  child: const HomeCard(),
                ),
              ),
              const RSizedBox.vertical(AppSize.s30),
              Visibility(
                visible: AppConstants.role == 'admin' ||
                    AppConstants.type == 'clinic',
                child: BlocProvider.value(
                  value: BlocProvider.of<FinancesCubit>(context)
                    ..getFinancesFun(),
                  child: BlocBuilder<FinancesCubit, FinancesState>(
                    builder: (context, state) {
                      return switch (state) {
                        GetFinancesSuccessState() => SlideInRight(
                            child: SizedBox(
                              height: AppSize.s70,
                              child: Row(
                                children: [
                                  const SvgPictureCustom(
                                    assetsName: IconAssets.payout,
                                    height: AppSize.s30,
                                  ),
                                  const SizedBox(
                                    width: AppSize.s18,
                                  ),
                                  TextCustom(
                                    text: LocaleKeys.nextPayoutDate,
                                    textStyle: getRegularGilroyStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s20),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: AppSize.s80.w + 8,
                                    height: AppSize.s60.h - 4,
                                    padding: EdgeInsets.only(
                                        right: AppPadding.p14,
                                        left: AppPadding.p14,
                                        top: AppPadding.p8,
                                        bottom: AppPadding.p4),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFADCCCC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppSize.s12.r),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: TextCustom(
                                            text: DateFormat(
                                                    'dMMM',
                                                    AppConstants.language
                                                        ? 'ar'
                                                        : 'en')
                                                .format(DateTime.parse(state
                                                    .financesEntity
                                                    .resultEntity
                                                    .response
                                                    .nextPayoutDate)),
                                            textStyle: getRegularGilroyStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s18),
                                          ),
                                        ),
                                        TextCustom(
                                          text: DateFormat(
                                                  'y',
                                                  AppConstants.language
                                                      ? 'ar'
                                                      : 'en')
                                              .format(DateTime.now()),
                                          textStyle: getRegularGilroyStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s14),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        GetFinancesErrorState() => const SizedBox(),
                        GetFinancesLoadingState() => ShimmerCustom(
                              child: SizedBox(
                            height: AppSize.s70,
                            child: Row(
                              children: [
                                const SvgPictureCustom(
                                  assetsName: IconAssets.payout,
                                  height: AppSize.s30,
                                ),
                                const SizedBox(
                                  width: AppSize.s18,
                                ),
                                TextCustom(
                                  text: LocaleKeys.nextPayoutDate,
                                  textStyle: getRegularGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s20),
                                ),
                                const Spacer(),
                                Container(
                                  width: AppSize.s80.w + 8,
                                  height: AppSize.s60.h + 8,
                                  padding: EdgeInsets.only(
                                      right: AppPadding.p14,
                                      left: AppPadding.p14,
                                      top: AppPadding.p8,
                                      bottom: AppPadding.p4),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFADCCCC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s12.r),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: TextCustom(
                                          text: DateFormat(
                                                  'dMMM',
                                                  AppConstants.language
                                                      ? 'ar'
                                                      : 'en')
                                              .format(DateTime.now()),
                                          textStyle: getRegularGilroyStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s18),
                                        ),
                                      ),
                                      Flexible(
                                        child: TextCustom(
                                          text: DateFormat(
                                                  'y',
                                                  AppConstants.language
                                                      ? 'ar'
                                                      : 'en')
                                              .format(DateTime.now()),
                                          textStyle: getRegularGilroyStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s14),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        _ => const SizedBox(),
                      };
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.calendarRoute);
                  },
                  child: TextCustom(
                    text: LocaleKeys.viewAll,
                    textStyle: getRegularGilroyStyle(
                        color: ColorManager.black, fontSize: FontSize.s12),
                  ),
                ),
              ),
              SizedBox(
                // height:context.height,
                child: BlocProvider.value(
                  value: BlocProvider.of<AppointmentsCubit>(context)
                    ..getAppointmentsFun(),
                  child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
                    listener: (context, appointmentsState) {},
                    builder: (context, appointmentsState) {
                      var appointmentsCubit = AppointmentsCubit.get(context);
                      return switch (appointmentsState) {
                        GetAppointmentsSuccessState() => SfCalendar(
                            showNavigationArrow: true,
                            allowViewNavigation: false,
                            onTap: (c) {
                              if (c.targetElement.name == 'calendarCell') {
                                return;
                              }
                              navigator(context, Routes.servicesRoute);
                              // if(c.resource?.id == '0000'){
                              //   navigator(context, Routes.servicesRoute);
                              // }
                            },
                            resourceViewSettings: ResourceViewSettings(
                              visibleResourceCount: appointmentsState
                                          .appointmentsEntity
                                          .resultEntity
                                          .response
                                          .length <
                                      2
                                  ? 1
                                  : 2,
                            ),
                            view: CalendarView.timelineDay,
                            // allowedViews: const [
                            //   CalendarView.timelineDay,
                            //   CalendarView.timelineWeek,
                            //   CalendarView.timelineMonth,
                            // ],
                            onSelectionChanged: (calendarSelectionDetails) {},
                            firstDayOfWeek: 1,
                            // timeSlotViewSettings: const TimeSlotViewSettings(
                            //   startHour: 9,
                            //   endHour: 18,
                            // ),
                            dataSource: MeetingDataSource(
                                shiftCollection(
                                    appointmentsState, appointmentsCubit),
                                calendarResource(appointmentsState)),

                            // view: CalendarView.,
                          ),
                        GetAppointmentsErrorState() => const ErrorsWidget(),
                        GetAppointmentsLoadingState() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        _ => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      };
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Appointment> shiftCollection(
      GetAppointmentsSuccessState state, AppointmentsCubit appointmentsCubit) {
    List<Appointment> shiftCollectionList = <Appointment>[];
    List<Object>? employeeIds = [];
    // for (var calendarResource in calendarResource(state)) {
    //   employeeIds = [calendarResource.id];
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
            startTimeZone: 'Egypt Standard Time',
            endTimeZone: 'Egypt Standard Time',
            resourceIds: employeeIds));
      }
    }
    return shiftCollectionList;
  }

  List<CalendarResource> calendarResource(GetAppointmentsSuccessState state) {
    return List.generate(
        state.appointmentsEntity.resultEntity.response.length,
        (index) => CalendarResource(
            id: state.appointmentsEntity.resultEntity.response[index].serviceId
                .toString()
                .replaceAll('(', '')
                .replaceAll(')', ''),
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

enum SampleItem { today, week, halfMonth, month, custom }

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SalesCubit>(context)..getSalesFun(),
      child: BlocBuilder<SalesCubit, SalesState>(
        builder: (context, state) {
          var salesCubit = SalesCubit.get(context);
          return switch (state) {
            GetSalesSuccessState() => Container(
                width: context.tablet ? context.width - 40 : AppSize.s100 * 3.8,
                height: AppSize.s100.h * 2.68,
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p14),
                decoration: ShapeDecoration(
                  color: ColorManager.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextCustom(
                          text: state
                              .salesEntity.resultEntity.response.report1.name,
                          color: ColorManager.white,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                        ),
                        const Spacer(),
                        PopupMenuButton<SampleItem>(
                          iconColor: ColorManager.white,
                          color: ColorManager.textFormColor,
                          offset: const Offset(0, 50),
                          initialValue: selectedMenu,
                          position: PopupMenuPosition.under,
                          // Callback that sets the selected popup menu item.
                          onSelected: (SampleItem item) {
                            if (item.name == 'custom') {
                              salesCubit.filter = '';
                              bottomSheetCustom(
                                  height: AppSize.s100 * 4.7,
                                  context: context,
                                  body: Column(
                                    children: [
                                      Expanded(
                                        child: DefaultTextStyle(
                                            style: const TextStyle(
                                              color: ColorManager.black,
                                              fontSize: 22.0,
                                            ),
                                            textAlign: TextAlign.center,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  AppPadding.p12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: AppSize.s14.h,
                                                  ),
                                                  SfDateRangePicker(
                                                    // onSelectionChanged: _onSelectionChanged,
                                                    selectionMode:
                                                        DateRangePickerSelectionMode
                                                            .range,

                                                    rangeSelectionColor:
                                                        ColorManager.rose1,
                                                    endRangeSelectionColor:
                                                        ColorManager.secondary,
                                                    startRangeSelectionColor:
                                                        ColorManager.secondary,

                                                    backgroundColor:
                                                        const Color(0xFFFBEEEE),
                                                    toggleDaySelection: true,
                                                    monthCellStyle:
                                                        DateRangePickerMonthCellStyle(
                                                      textStyle:
                                                          getMediumGilroyStyle(
                                                              color:
                                                                  ColorManager
                                                                      .black),
                                                    ),
                                                    headerStyle: DateRangePickerHeaderStyle(
                                                        backgroundColor:
                                                            ColorManager.white,
                                                        textStyle:
                                                            getSemiBoldGilroyStyle(
                                                                color:
                                                                    ColorManager
                                                                        .black,
                                                                fontSize:
                                                                    FontSize
                                                                        .s18),
                                                        textAlign:
                                                            TextAlign.center),
                                                    showNavigationArrow: true,
                                                    onSelectionChanged:
                                                        (dateRangePickerSelectionChangedArgs) {
                                                      salesCubit
                                                          .start = DateFormat(
                                                              'M/d/y',
                                                              AppConstants
                                                                      .language
                                                                  ? 'ar'
                                                                  : 'en')
                                                          .format(DateTime.parse(
                                                              dateRangePickerSelectionChangedArgs
                                                                  .value
                                                                  .startDate
                                                                  .toString()));
                                                      salesCubit.end = DateFormat(
                                                              'M/d/y',
                                                              AppConstants
                                                                      .language
                                                                  ? 'ar'
                                                                  : 'en')
                                                          .format(dateRangePickerSelectionChangedArgs
                                                                      .value
                                                                      .endDate !=
                                                                  null
                                                              ? DateTime.parse(
                                                                  dateRangePickerSelectionChangedArgs
                                                                      .value
                                                                      .endDate
                                                                      .toString())
                                                              : DateTime.now());
                                                    },
                                                    selectionColor:
                                                        ColorManager.secondary1,
                                                    initialSelectedRange:
                                                        PickerDateRange(
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days:
                                                                            4)),
                                                            DateTime.now().add(
                                                                const Duration(
                                                                    days: 3))),
                                                  ),
                                                  SizedBox(
                                                    height: AppSize.s20.h,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(AppPadding.p20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButtonCustom(
                                              width: (AppSize.s100).w,
                                              height: AppSize.s40,
                                              radius: AppSize.s24.r,
                                              colors: ColorManager.white,
                                              borderColor: ColorManager.grey,
                                              text: LocaleKeys.cancel,
                                              textStyle: getMediumGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s14),
                                              onPressed: () {
                                                salesCubit.filter = 'today';
                                                salesCubit.getSalesFun();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButtonCustom(
                                              width: (AppSize.s100).w,
                                              height: AppSize.s40,
                                              radius: AppSize.s24.r,
                                              colors: ColorManager.secondary,
                                              borderColor:
                                                  ColorManager.secondary,
                                              text: LocaleKeys.setDate,
                                              textStyle: getMediumGilroyStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s14),
                                              onPressed: () {
                                                salesCubit.getSalesFun();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            } else {
                              salesCubit.filter = item.name;
                              selectedMenu = item;
                              salesCubit.getSalesFun();
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.today,
                              child: TextCustom(text: LocaleKeys.today),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.week,
                              child: TextCustom(text: LocaleKeys.lastWeek),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.halfMonth,
                              child: TextCustom(text: LocaleKeys.halfMonth),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.month,
                              child: TextCustom(text: LocaleKeys.lastMonth),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.custom,
                              child: TextCustom(text: LocaleKeys.custom),
                            ),
                          ],
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       bottomSheetCustom(
                        //         height: 552,
                        //         context: context,
                        //         body: Material(
                        //           borderRadius: BorderRadius.circular(AppSize.s30.r),
                        //           child: BlocProvider(
                        //             create: (context) => AllClinicsCubit(),
                        //             child:
                        //             BlocConsumer<AllClinicsCubit, AllClinicsState>(
                        //               listener: (context, state) {},
                        //               builder: (context, state) {
                        //                 var clinicCubit = AllClinicsCubit.get(context);
                        //                 return SizedBox(
                        //                   width: context.width,
                        //                   child: Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: AppPadding.p10),
                        //                     child: Column(
                        //                       children: [
                        //                         const RSizedBox.vertical(AppSize.s16),
                        //                         Row(
                        //                           mainAxisAlignment:
                        //                           MainAxisAlignment.spaceBetween,
                        //                           children: [
                        //                             TextButton(
                        //                                 onPressed: () {},
                        //                                 child: TextCustom(
                        //                                   text: 'Clear',
                        //                                   textStyle:
                        //                                   getMediumGilroyStyle(
                        //                                       color: ColorManager
                        //                                           .black,
                        //                                       fontSize:
                        //                                       FontSize.s14),
                        //                                 )),
                        //                             SizedBox(
                        //                               height: AppSize.s30,
                        //                               child: Align(
                        //                                 alignment:
                        //                                 Alignment.bottomCenter,
                        //                                 child: TextCustom(
                        //                                   text: LocaleKeys.filter,
                        //                                   fontSize: FontSize.s18,
                        //                                   fontWeight:
                        //                                   FontWeightManager.bold,
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                             IconButton(
                        //                               onPressed: () {
                        //                                 Navigator.pop(context);
                        //                               },
                        //                               icon: Container(
                        //                                 // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                        //                                 padding: EdgeInsets.all(
                        //                                     AppPadding.p8),
                        //                                 width: AppSize.s30.h,
                        //                                 height: AppSize.s30.h,
                        //                                 decoration:
                        //                                 const ShapeDecoration(
                        //                                   color: ColorManager.white1,
                        //                                   shape: OvalBorder(),
                        //                                 ),
                        //                                 child: const SvgPictureCustom(
                        //                                   assetsName: IconAssets.close,
                        //                                   color: null,
                        //                                 ),
                        //                               ),
                        //                             )
                        //                           ],
                        //                         ),
                        //                         ListView.builder(
                        //                           physics:
                        //                           const NeverScrollableScrollPhysics(),
                        //                           shrinkWrap: true,
                        //                           itemBuilder: (context, index) {
                        //                             return SelectWidgetCustom<int>(
                        //                               radius: AppSize.s20.r,
                        //                               selectedColor:
                        //                               ColorManager.secondary1,
                        //                               disabledColor:
                        //                               ColorManager.white1,
                        //                               index: index,
                        //                               value: clinicCubit
                        //                                   .serviceFilterModel[index]
                        //                               ['id'],
                        //                               groupValue:
                        //                               clinicCubit.filterValue,
                        //                               onChanged: (value) => clinicCubit
                        //                                   .selectFilter(value!),
                        //                               name: clinicCubit
                        //                                   .serviceFilterModel[index]
                        //                               ['name'],
                        //                             );
                        //                           },
                        //                           itemCount: clinicCubit
                        //                               .serviceFilterModel.length,
                        //                         ),
                        //                         const RSizedBox.vertical(AppSize.s24),
                        //                         TextCustom(
                        //                           text: '${LocaleKeys.sortBy.tr()} ${LocaleKeys.date.tr()}',
                        //                           fontSize: FontSize.s18,
                        //                           fontWeight: FontWeightManager.bold,
                        //                         ),
                        //                         const RSizedBox.vertical(AppSize.s20),
                        //                         SizedBox(
                        //                           // width: context.width/1.1,
                        //                           height: AppSize.s60,
                        //                           child: ListView.builder(
                        //                             scrollDirection: Axis.horizontal,
                        //                             physics:
                        //                             const BouncingScrollPhysics(),
                        //                             shrinkWrap: true,
                        //                             itemBuilder: (context, index) {
                        //                               return SelectWidgetCustom<int>(
                        //                                 radius: AppSize.s30,
                        //                                 selectedColor:
                        //                                 ColorManager.secondary1,
                        //                                 disabledColor:
                        //                                 ColorManager.white1,
                        //                                 width: AppSize.s100.w * 1.2,
                        //                                 titleWidth: AppSize.s100.w,
                        //                                 index: index,
                        //                                 value: clinicCubit
                        //                                     .sortSalesModel[index]['id'],
                        //                                 groupValue:
                        //                                 clinicCubit.sortValue,
                        //                                 onChanged: (value) =>
                        //                                     clinicCubit
                        //                                         .selectSort(value!),
                        //                                 name: clinicCubit
                        //                                     .sortSalesModel[index]['name'],
                        //                               );
                        //                             },
                        //                             itemCount:
                        //                             clinicCubit.sortSalesModel.length,
                        //                           ),
                        //                         ),
                        //                         const RSizedBox.vertical(AppSize.s30),
                        //                         ElevatedButtonCustom(
                        //                           onPressed: () {
                        //                             Navigator.pop(context);
                        //                           },
                        //                           text: 'Apply',
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     icon: const SvgPictureCustom(
                        //       assetsName: IconAssets.dots,
                        //       color: ColorManager.white,
                        //     )),
                      ],
                    ),
                    CardDataWidget(
                      amount: state
                          .salesEntity.resultEntity.response.report1.sales
                          .toStringAsFixed(1),
                      appointments: state.salesEntity.resultEntity.response
                          .report1.appointments
                          .toString(),
                      currency: state
                          .salesEntity.resultEntity.response.report1.currency,
                    ),
                    const RSizedBox.vertical(AppSize.s20),
                    Divider(
                      color: ColorManager.grey.withOpacity(0.20),
                      thickness: 1,
                      height: 0,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p20),
                            child: SizedBox(
                              // height: AppSize.s60.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextCustom(
                                    text: state.salesEntity.resultEntity
                                        .response.report2.name,
                                    color: ColorManager.white,
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                  CardDataWidget(
                                    amount: state.salesEntity.resultEntity
                                        .response.report2.sales
                                        .toStringAsFixed(1),
                                    appointments: state.salesEntity.resultEntity
                                        .response.report2.appointments
                                        .toString(),
                                    currency: state.salesEntity.resultEntity
                                        .response.report2.currency,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: ColorManager.grey.withOpacity(0.20),
                            thickness: 1,
                            indent: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p20),
                            child: SizedBox(
                              // height: AppSize.s70,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextCustom(
                                    text: state.salesEntity.resultEntity
                                        .response.report3.name,
                                    color: ColorManager.white,
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.regular,
                                  ),
                                  CardDataWidget(
                                    amount: state.salesEntity.resultEntity
                                        .response.report3.sales
                                        .toStringAsFixed(1),
                                    appointments: state.salesEntity.resultEntity
                                        .response.report3.appointments
                                        .toString(),
                                    currency: state.salesEntity.resultEntity
                                        .response.report3.currency,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            GetSalesErrorState() => const SizedBox(),
            GetSalesLoadingState() => ShimmerCustom(
                  child: Container(
                width: AppSize.s100 * 3.8,
                height: AppSize.s100.h * 2.68,
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p14),
                decoration: ShapeDecoration(
                  color: ColorManager.lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                  ),
                ),
              )),
            _ => ShimmerCustom(
                  child: Container(
                width: AppSize.s100 * 3.8,
                height: AppSize.s100.h * 2.68,
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p14),
                decoration: ShapeDecoration(
                  color: ColorManager.lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                  ),
                ),
              )),
          };
        },
      ),
    );
  }
}

class CardDataWidget extends StatelessWidget {
  final String amount;
  final String currency;
  final String appointments;

  const CardDataWidget(
      {required this.amount,
      required this.currency,
      required this.appointments,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RSizedBox.vertical(AppSize.s8),

        SizedBox(
          width: AppSize.s100 * 1.4,
          child: TextCustom(
            text: '${LocaleKeys.aED.tr()} $amount',
            maxLines: 2,
            overflow: TextOverflow.clip,
            textStyle: getSemiBoldGilroyStyle(
              color: ColorManager.white,
              fontSize: FontSize.s22,
            ),
          ),
        ),
        const RSizedBox.vertical(AppSize.s6),
        TextCustom(
          text: '$appointments ${LocaleKeys.appointments.tr()}',
          textStyle: getRegularGilroyStyle(
            color: ColorManager.white,
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }
}
