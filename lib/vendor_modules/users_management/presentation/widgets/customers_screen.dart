import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/users_management/domain/entities/customers_entity.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/controller/customers_cubit/customers_cubit.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/controller/customers_cubit/customers_state.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../core/widgets/text_custom/text_custom.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BlocProvider.value(
        value: BlocProvider.of<CustomersCubit>(context)..getCustomersFun(),
        child: BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            return switch (state) {
              GetCustomersSuccessState() => SfDataGridTheme(
                  data: SfDataGridThemeData(
                      headerColor: ColorManager.primary,
                      filterIconColor: ColorManager.white,
                      sortIconColor: ColorManager.white,
                      filterPopupTextStyle: TextStyle(
                        locale: Locale(AppConstants.language ? 'ar' : 'en'),
                      )),
                  child: SfDataGrid(
                      allowSorting: true,
                      allowFiltering: true,
                      allowEditing: true,
                      allowPullToRefresh: false,
                      navigationMode: GridNavigationMode.cell,
                      rowsPerPage: 3,
                      showSortNumbers: true,
                      // selectionMode: SelectionMode.,
                      // onCellDoubleTap: (details) {
                      //   print(details.rowColumnIndex.columnIndex);
                      // },
                      source: EmployeeDataSource(
                          employees:
                              state.customersEntity.resultEntity.response),
                      onFilterChanged: (DataGridFilterChangeDetails details) {},
                      onQueryRowHeight: (details) {
                        // Set the row height as 70.0 to the column header row.
                        return details.rowIndex == 0
                            ? AppSize.s60
                            : AppSize.s50;
                        // return details.getIntrinsicRowHeight(details.rowIndex);
                      },
                      columnWidthMode: ColumnWidthMode.auto,
                      columnWidthCalculationRange:
                          ColumnWidthCalculationRange.allRows,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      columns: <GridColumn>[
                        buildGridColumn(
                          columnID: 'id',
                          columnName: LocaleKeys.id.tr(),
                        ),
                        buildGridColumn(
                            columnID: 'name', columnName: LocaleKeys.name.tr()),
                        buildGridColumn(
                            columnID: 'email',
                            columnName: LocaleKeys.email.tr()),
                        buildGridColumn(
                            columnID: 'phone',
                            columnName: LocaleKeys.phone.tr()),
                      ])),
              GetCustomersErrorState() => const ErrorsWidget(),
              GetCustomersLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            };
          },
        ),
      ),
    );
  }

  GridColumn buildGridColumn(
      {required String columnID, required String columnName}) {
    return GridColumn(
        // columnWidthMode: ColumnWidthMode.fill,
        columnName: columnID,
        // filterIconPadding:
        //     const EdgeInsets.symmetric(horizontal: 2.0),
        label: ColumnNameWidget(
          name: columnName,
        ));
  }
}

class ColumnNameWidget extends StatelessWidget {
  const ColumnNameWidget({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: TextCustom(
          text: name,
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s12,
          color: ColorManager.white,
        ));
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<ResponseEntity> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'phone', value: e.mobilePhone),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: ColorManager.secondary,
        cells: row.getCells().map<Widget>((dataGridCell) {
      // print(dataGridCell.columnName);
      return Container(
        height: AppSize.s100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        color: ColorManager.white1,
        child: TextCustom(
          textAlign: TextAlign.start,
          text: dataGridCell.value.toString(),
          textStyle: getMediumGilroyStyle(
              color: dataGridCell.columnName == 'id'
                  ? ColorManager.black
                  : ColorManager.grey,
              fontSize: FontSize.s12),
        ),
      );
    }).toList());
  }
}
