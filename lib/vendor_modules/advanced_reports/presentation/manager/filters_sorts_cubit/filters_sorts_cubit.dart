import 'package:doctor_ack/languages/locale_keys.g.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import 'filters_sorts_state.dart';

enum Filters { months, days, times }

class FiltersSortsCubit extends Cubit<FiltersSortsState> {
  FiltersSortsCubit() : super(FiltersSortsInitial());

  static FiltersSortsCubit get(context) => BlocProvider.of(context);

  String sortCustomersValue = 'lifetime';
  String filterCustomersValue = 'times';

  String sortSalesValue = 'lifetime';
  String filterSalesValue = 'months';

  int filterServiceValue = 1;

  selectSortCustomer(String val) {
    emit(SelectSortLoadingState());
    sortCustomersValue = val;
    emit(SelectSortState());
  }

  selectFilterCustomer(String val) {
    emit(SelectFilterLoadingState());
    filterCustomersValue = val;
    emit(SelectFilterState());
  }

  selectSortSale(String val) {
    emit(SelectSortSalesLoadingState());
    sortSalesValue = val;
    emit(SelectSortSalesState());
  }

  selectFilterSale(String val) {
    emit(SelectFilterSalesLoadingState());
    filterSalesValue = val;
    emit(SelectFilterSalesState());
  }

  selectFilterService(int val) {
    emit(SelectFilterServiceLoadingState());
    filterServiceValue = val;
    emit(SelectFilterServiceState());
  }

  int sortBy = 0;
  int categoryId = 0;

  List<Map<String, dynamic>> sortModel = [
    {"name": LocaleKeys.lastWeek.tr(), "id": 7},
    {"name": LocaleKeys.halfMonth.tr(), "id": 15},
    {"name": LocaleKeys.lastMonth.tr(), "id": 30},
    {"name": LocaleKeys.custom.tr(), "id": 0},
  ];
  clearFilter() {
    sortBy = 0;
    categoryId = 0;
    emit(ClearFilterCalendarState());
  }

  selectCalendarFilter(int val) {
    emit(SelectFilterCalendarLoadingState());
    categoryId = val;
    emit(SelectFilterCalendarState());
  }

  selectCalendarSort(int val) {
    emit(SelectSortCalendarLoadingState());
    sortBy = val;
    emit(SelectSortCalendarState());
  }
}
