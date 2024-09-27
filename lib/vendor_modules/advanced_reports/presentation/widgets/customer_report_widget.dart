import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/advanced_customers_cubit/advanced_customers_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/advanced_customers_cubit/advanced_customers_state.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/filters_sorts_cubit/filters_sorts_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/widgets/drop_down/drop_dwon_button.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../domain/entities/advanced_customers_entity.dart';
import '../manager/filters_sorts_cubit/filters_sorts_state.dart';

enum SampleItem { lifetime, today, lastweek, lastmonth, custom }

class CustomerReportWidget extends StatelessWidget {
  const CustomerReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider.value(
          value: BlocProvider.of<FiltersSortsCubit>(context),
          child: BlocBuilder<FiltersSortsCubit, FiltersSortsState>(
            builder: (context, state) {
              var filterCubit = FiltersSortsCubit.get(context);
              return Row(
                children: [
                  TextCustom(
                    text: LocaleKeys.customerReport,
                    textStyle: getSemiBoldGilroyStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  const RSizedBox.horizontal(AppSize.s14),
                  SizedBox(
                    width: AppSize.s100.w * 1.3,
                    child: CustomDropdownButton(
                      dropdownHeight: AppSize.s40,
                      hint: LocaleKeys.filterBy,
                      buttonWidth: AppSize.s80,
                      value: filterCubit.filterCustomersValue,
                      dropdownItems: [
                        DropdownMenuItem<String>(
                          value: 'days',
                          child: TextCustom(
                            text: LocaleKeys.days,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: 'times',
                          child: TextCustom(
                            text: LocaleKeys.times,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (onChanged) {
                        // selectedSales = onChanged.toString();
                        // setState(() {});
                        filterCubit.selectFilterCustomer(onChanged!);
                        AdvancedCustomersCubit.get(context).filter =
                            filterCubit.filterCustomersValue;

                        AdvancedCustomersCubit.get(context)
                            .getAdvancedCustomersFun();
                      },
                      onSave: (String? value) {
                        // selectedSales = value.toString();
                        filterCubit.selectFilterCustomer(value!);
                        AdvancedCustomersCubit.get(context).filter =
                            filterCubit.filterCustomersValue;

                        AdvancedCustomersCubit.get(context)
                            .getAdvancedCustomersFun();
                      },
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<SampleItem>(
                    // color: ColorManager.textFormColor,
                    surfaceTintColor: ColorManager.white,
                    offset: const Offset(0, 50),
                    initialValue: SampleItem.today,
                    position: PopupMenuPosition.under,
                    // Callback that sets the selected popup menu item.
                    onSelected: (SampleItem item) {
                      // setState(() {
                      //   selectedMenu = item;
                      // });
                      filterCubit.selectSortCustomer(item.name);
                      AdvancedCustomersCubit.get(context).sort =
                          filterCubit.sortCustomersValue;

                      AdvancedCustomersCubit.get(context)
                          .getAdvancedCustomersFun();
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<SampleItem>>[
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.lifetime,
                        child: TextCustom(text: LocaleKeys.lifetime),
                      ),
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.today,
                        child: TextCustom(text: LocaleKeys.today),
                      ),
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.lastweek,
                        child: TextCustom(text: LocaleKeys.thisWeek),
                      ),
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.lastmonth,
                        child: TextCustom(text: LocaleKeys.thisMonth),
                      ),
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.custom,
                        child: TextCustom(text: 'Custom'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        BlocProvider.value(
          value: BlocProvider.of<AdvancedCustomersCubit>(context)
            ..getAdvancedCustomersFun(),
          child: BlocBuilder<AdvancedCustomersCubit, AdvancedCustomersState>(
            builder: (context, state) {
              var customerCubit = AdvancedCustomersCubit.get(context);
              return switch (state) {
                GetAdvancedCustomersSuccessState() => ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                    child: SfCartesianChart(
                        backgroundColor: ColorManager.white1,
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          // labelRotation:
                          //     selectedCustomer == LocaleKeys.days ? 0 : -45,
                          axisLine: const AxisLine(
                              color: ColorManager.secondary2, width: 0),
                          labelStyle: getRegularGilroyStyle(
                              color: ColorManager.divider,
                              fontSize: FontSize.s12),
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          axisLine: const AxisLine(
                              color: ColorManager.secondary2, width: 0),
                          minimum: 0,
                          maximum: 50,
                          interval: 10,
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                        tooltipBehavior: customerCubit.tooltipCustomer,
                        // title: ChartTitle(
                        //     text: LocaleKeys.customerReport.tr(),
                        //     alignment: ChartAlignment.near,
                        //     textStyle: Theme.of(context).textTheme.headlineMedium),
                        palette: const [
                          ColorManager.primary,
                          ColorManager.secondary
                        ],
                        series: <CartesianSeries<AdvancedCustomerEntity,
                            String>>[
                          ColumnSeries<AdvancedCustomerEntity, String>(
                              dataSource: state.advancedCustomersEntity
                                  .resultEntity.response,
                              xValueMapper: (AdvancedCustomerEntity data, _) =>
                                  data.hour,
                              yValueMapper: (AdvancedCustomerEntity data, _) =>
                                  int.parse(data.number),
                              name: customerCubit.filter == 'days'
                                  ? '${LocaleKeys.customer.tr()}/${LocaleKeys.day.tr()}'
                                  : '${LocaleKeys.customer.tr()}/${LocaleKeys.time.tr()}',
                              borderRadius: BorderRadius.circular(AppSize.s2),
                              sortFieldValueMapper: (datum, index) {},
                              sortingOrder: SortingOrder.ascending,
                              xAxisName: LocaleKeys.month,
                              yAxisName: LocaleKeys.sales,
                              color: ColorManager.secondary1),
                        ]),
                  ),
                GetAdvancedCustomersErrorState() => ErrorsWidget(
                    onPress: () => customerCubit.getAdvancedCustomersFun(),
                  ),
                GetAdvancedCustomersLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                _ => const Center(
                    child: CircularProgressIndicator(),
                  ),
              };
            },
          ),
        ),
      ],
    );
  }
}
