import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/domain/entities/advanced_sales_entity.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/filters_sorts_cubit/filters_sorts_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/widgets/drop_down/drop_dwon_button.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../manager/advanced_sales_cubit/advanced_sales_cubit.dart';
import '../manager/advanced_sales_cubit/advanced_sales_state.dart';
import '../manager/filters_sorts_cubit/filters_sorts_state.dart';

enum SampleItem { lifetime, today, lastweek, lastmonth, custom }

class SaleReportWidget extends StatelessWidget {
  const SaleReportWidget({super.key});

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
                    text: LocaleKeys.salesReport,
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
                      value: filterCubit.filterSalesValue,
                      dropdownItems: [
                        DropdownMenuItem<String>(
                          value: 'months',
                          child: TextCustom(
                            text: LocaleKeys.month,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
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
                      ],
                      onChanged: (onChanged) {
                        // selectedSales = onChanged.toString();
                        // setState(() {});
                        filterCubit.selectFilterSale(onChanged!);
                        AdvancedSalesCubit.get(context).filter =
                            filterCubit.filterSalesValue;

                        AdvancedSalesCubit.get(context).getAdvancedSalesFun();
                      },
                      onSave: (String? value) {
                        // selectedSales = value.toString();
                        filterCubit.selectFilterSale(value!);
                        AdvancedSalesCubit.get(context).filter =
                            filterCubit.filterSalesValue;
                        AdvancedSalesCubit.get(context).getAdvancedSalesFun();
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
                      filterCubit.selectSortSale(item.name.toString());
                      AdvancedSalesCubit.get(context).sort =
                          filterCubit.sortSalesValue;

                      AdvancedSalesCubit.get(context).getAdvancedSalesFun();
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
          value: BlocProvider.of<AdvancedSalesCubit>(context)
            ..getAdvancedSalesFun(),
          child: BlocBuilder<AdvancedSalesCubit, AdvancedSalesState>(
            builder: (context, state) {
              var customerCubit = AdvancedSalesCubit.get(context);
              return switch (state) {
                GetAdvancedSalesSuccessState() => SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        labelStyle: getRegularGilroyStyle(
                            color: ColorManager.black, fontSize: FontSize.s12),
                      ),
                      primaryYAxis: NumericAxis(
                          majorGridLines: MajorGridLines(
                              width: 1,
                              color: const Color(0xFFE4E4E4).withOpacity(0.2)),
                          minimum: 0,
                          maximum: 10000,
                          interval: 2000),
                      tooltipBehavior: customerCubit.tooltip,
                      // title: ChartTitle(
                      //     text: LocaleKeys.salesReport.tr(),
                      //     alignment: ChartAlignment.far,
                      //     textStyle: Theme.of(context).textTheme.headlineMedium),
                      series: <CartesianSeries<AdvancedSaleEntity, String>>[
                        LineSeries<AdvancedSaleEntity, String>(
                            dataSource:
                                state.advancedSalesEntity.resultEntity.response,
                            xValueMapper: (AdvancedSaleEntity data, _) =>
                                DateFormat(customerCubit.filter == 'months'
                                        ? 'MMM'
                                        : 'EEE')
                                    .format(DateTime.parse(
                                        customerCubit.filter == 'months'
                                            ? '${data.date}-01'
                                            : data.date))
                                    .toString(),
                            yValueMapper: (AdvancedSaleEntity data, _) =>
                                data.amount,
                            name:
                                '${LocaleKeys.sales.tr()}/${LocaleKeys.month.tr()}',
                            // borderRadius: BorderRadius.circular(AppSize.s2),
                            sortingOrder: SortingOrder.ascending,
                            // xAxisName: LocaleKeys.month,
                            // yAxisName: LocaleKeys.sales,
                            color: ColorManager.primary)
                      ]),
                GetAdvancedSalesErrorState() => ErrorsWidget(
                    onPress: () => customerCubit.getAdvancedSalesFun(),
                  ),
                GetAdvancedSalesLoadingState() => const Center(
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
