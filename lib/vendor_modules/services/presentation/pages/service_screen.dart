import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/service/presentation/controller/service_cubit.dart';
import 'package:doctor_ack/vendor_modules/services/presentation/manager/block_time_cubit/block_time_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../modules/clinic/presentaion/controllers/available_times_cubit/available_times_cubit.dart';
import '../../../../modules/clinic/presentaion/controllers/available_times_cubit/available_times_state.dart';
import '../../../../modules/clinic/presentaion/widgets/service_data_widget.dart';
import '../../../../modules/service/presentation/controller/service_state.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        return ScaffoldCustom(
          appBarCustom: AppBarCustom(
            centerTitle: false,
            text: state is GetServiceSuccessState
                ? state.serviceEntity.resultEntity.response.name
                : 'Hydra Facial',
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: AppPadding.p16),
                  child: SvgPictureCustom(
                    assetsName: IconAssets.share,
                    color: null,
                    height: AppSize.s34.h,
                    width: AppSize.s34.h,
                  ),
                ),
              )
            ],
          ),
          body: SmartRefresher(
            controller: ServiceCubit.get(context).refreshController,
            onRefresh: () => ServiceCubit.get(context).getService(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
                child: Center(
                  child: Column(
                    children: [
                      //Image
                      const ServiceDataWidget(),

                      SizedBox(
                        height: AppSize.s24.h,
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
                        child: BlocConsumer<AvailableTimesCubit,
                            AvailableTimesState>(
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
                            var availableCubit =
                                AvailableTimesCubit.get(context);
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
                              buttonLables: state
                                      is GetAvailableTimesSuccessState
                                  ? List.generate(
                                      state.availableTimesEntity.resultEntity
                                          .response.length,
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
                              buttonValues:
                                  state is GetAvailableTimesSuccessState
                                      ? List.generate(
                                          state.availableTimesEntity
                                              .resultEntity.response.length,
                                          (index) => state
                                              .availableTimesEntity
                                              .resultEntity
                                              .response[index]
                                              .start)
                                      : const [],
                              defaultSelected: null,
                              // height: AppSize.s40,
                              radioButtonValue: (value) {
                                BlockTimeCubit.get(context).time =
                                    availableCubit.convert24HourFormat(value);
                              },
                              selectedColor: ColorManager.primary,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: ElevatedButtonCustom(
              radius: AppSize.s50,
              text: LocaleKeys.blockAvailableTime,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
              fontSize: FontSize.s18,
              onPressed: () async {
                bottomSheetCustom(
                    height: context.height / 1.1,
                    context: context,
                    body: Column(
                      children: [
                        DefaultTextStyle(
                            style: const TextStyle(
                              color: ColorManager.black,
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
                                    text: LocaleKeys.availableTimes,
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeightManager.medium,
                                  )),
                                  SizedBox(
                                    height: AppSize.s16.h,
                                  ),
                                  TextCustom(
                                    text: LocaleKeys.selectDate,
                                    textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s14.h,
                                  ),
                                  SfDateRangePicker(
                                    // onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                    backgroundColor: const Color(0xFFFBEEEE),
                                    toggleDaySelection: true,
                                    monthCellStyle:
                                        DateRangePickerMonthCellStyle(
                                      textStyle: getMediumGilroyStyle(
                                          color: ColorManager.black),
                                    ),
                                    headerStyle: DateRangePickerHeaderStyle(
                                        backgroundColor: ColorManager.white,
                                        textStyle: getSemiBoldGilroyStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s18),
                                        textAlign: TextAlign.center),
                                    showNavigationArrow: true,

                                    selectionColor: ColorManager.secondary1,
                                    initialSelectedRange: PickerDateRange(
                                        DateTime.now()
                                            .subtract(const Duration(days: 4)),
                                        DateTime.now()
                                            .add(const Duration(days: 3))),
                                    onSelectionChanged:
                                        (dateRangePickerSelectionChangedArgs) {
                                      var dateStamp =
                                          dateRangePickerSelectionChangedArgs
                                              .value
                                              .toString()
                                              .split(' ');
                                      AvailableTimesCubit.get(context)
                                              .serviceID =
                                          state is GetServiceSuccessState
                                              ? state.serviceEntity.resultEntity
                                                  .response.id
                                              : 0;
                                      AvailableTimesCubit.get(context).date =
                                          DateFormat('M/d/y').format(
                                              DateTime.parse(dateStamp[0]));
                                      BlockTimeCubit.get(context).date =
                                          DateFormat('M/d/y').format(
                                              DateTime.parse(dateStamp[0]));

                                      AvailableTimesCubit.get(context)
                                          .getAvailableTimes();
                                    },
                                  ),
                                  SizedBox(
                                    height: AppSize.s20.h,
                                  ),
                                  TextCustom(
                                    text: LocaleKeys.blockTime,
                                    textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.s14.h,
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<AvailableTimesCubit>(
                                        context)
                                      ..getAvailableTimes(),
                                    child: BlocConsumer<AvailableTimesCubit,
                                        AvailableTimesState>(
                                      listener: (context, state) {
                                        if (state
                                            is GetAvailableTimesErrorState) {
                                          showToast(
                                            context,
                                            message:
                                                LocaleKeys.toastValidDate.tr(),
                                            // color: ColorManager.primary,
                                            type: MessageType.error,
                                          );
                                        }
                                      },
                                      buildWhen: (previous, current) {
                                        var cubit =
                                            AvailableTimesCubit.get(context);
                                        return cubit.date.isNotEmpty;
                                      },
                                      builder: (context, state) {
                                        var availableCubit =
                                            AvailableTimesCubit.get(context);
                                        return CustomRadioButton(
                                          horizontal: false,
                                          enableShape: true,
                                          elevation: 0,
                                          // radius: AppSize.s10.r,
                                          // shapeRadius: AppSize.s10.r,
                                          autoWidth: true,
                                          // width: AppSize.s100*1.63,
                                          wrapAlignment:
                                              WrapAlignment.spaceBetween,
                                          enableButtonWrap: true,
                                          disabledColor: ColorManager.white,

                                          unSelectedBorderColor:
                                              ColorManager.divider,
                                          customShape: const StadiumBorder(
                                              side: BorderSide(
                                            color: ColorManager.divider,
                                          )),
                                          spacing: AppPadding.p16,
                                          margin: EdgeInsets.only(
                                              bottom: AppPadding.p16),
                                          unSelectedColor: ColorManager.white,
                                          // disabledValues: const [2],
                                          buttonLables: state
                                                  is GetAvailableTimesSuccessState
                                              ? List.generate(
                                                  state
                                                      .availableTimesEntity
                                                      .resultEntity
                                                      .response
                                                      .length,
                                                  (index) =>
                                                      '${availableCubit.convert24To12HourFormat(state.availableTimesEntity.resultEntity.response[index].start)} - ${availableCubit.convert24To12HourFormat(state.availableTimesEntity.resultEntity.response[index].end)}')
                                              : const [],
                                          buttonTextStyle: ButtonTextStyle(
                                              unSelectedColor:
                                                  ColorManager.primary,
                                              disabledColor:
                                                  ColorManager.divider,
                                              textStyle: TextStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s12,
                                                fontFamily: 'Gilroy-SemiBold',
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                height: 0,
                                                letterSpacing: -0.24,
                                              ),
                                              selectedColor:
                                                  ColorManager.white),
                                          buttonValues: state
                                                  is GetAvailableTimesSuccessState
                                              ? List.generate(
                                                  state
                                                      .availableTimesEntity
                                                      .resultEntity
                                                      .response
                                                      .length,
                                                  (index) => state
                                                      .availableTimesEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .start)
                                              : const [],
                                          defaultSelected: null,
                                          // height: AppSize.s40,
                                          radioButtonValue: (value) {
                                            BlockTimeCubit.get(context).time =
                                                availableCubit
                                                    .convert24HourFormat(value);
                                          },
                                          selectedColor: ColorManager.primary,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: AppPadding.p20),
                          child: BlocBuilder<ServiceCubit, ServiceState>(
                            builder: (context, serviceState) =>
                                BlocConsumer<BlockTimeCubit, BlockTimeState>(
                              listener: (context, state) {
                                if (state is BlockTimeSuccessState) {
                                  showToast(context,
                                      message: LocaleKeys.toastTimeBlocked.tr(),
                                      type: MessageType.success);
                                  Navigator.pop(context);
                                } else if (state is BlockTimeErrorState) {
                                  showToast(context,
                                      message: state.message,
                                      type: MessageType.error);
                                }
                              },
                              builder: (context, state) {
                                var blockTimeCubit =
                                    BlockTimeCubit.get(context);
                                return state is BlockTimeLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButtonCustom(
                                        width: (AppSize.s100 * 3).w,
                                        radius: AppSize.s50.r,
                                        text: LocaleKeys.confirm,
                                        textStyle: getSemiBoldGilroyStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.s16),
                                        onPressed: () {
                                          if (serviceState
                                              is GetServiceSuccessState) {
                                            blockTimeCubit.serviceID =
                                                serviceState.serviceEntity
                                                    .resultEntity.response.id;
                                            blockTimeCubit.blockTime();
                                            // Navigator.pop(context);
                                          }
                                        },
                                      );
                              },
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
