import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../languages/locale_keys.g.dart';
import '../../../domain/entities/all_services_entity.dart';
import '../../../domain/use_cases/all_services_usecase.dart';

part 'all_services_state.dart';

class AllServicesCubit extends Cubit<AllServicesState> {
  final AllServicesUsecase allServicesUsecase;
  AllServicesCubit({
    required this.allServicesUsecase,
  }) : super(ClinicInitial());

  static AllServicesCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshVendorController =
      RefreshController(initialRefresh: false);
  String endpoint = EndPoints.getAllServicesEndpoint;
  String sortBy = '';
  int categoryId = 0;

  int clinicId = 0;

  List<Map<String, dynamic>> sortModel = [
    {"name": LocaleKeys.priceHighLow, "id": 'highest_price'},
    {"name": LocaleKeys.priceLowHigh, "id": 'lowest_price'},
    {"name": LocaleKeys.newest, "id": 'newest'},
    {"name": LocaleKeys.oldest, "id": 'oldest'},
    {"name": LocaleKeys.highRate, "id": 'high_rating'},
  ];

  clearFilter() {
    sortBy = '';
    categoryId = 0;
    emit(ClearFilterState());
  }

  selectFilter(int val) {
    emit(SelectFilterLoadingState());
    categoryId = val;
    emit(SelectFilterState());
  }

  selectSort(String val) {
    emit(SelectSortLoadingState());
    sortBy = val;
    emit(SelectSortState());
  }

  Future<void> getAllServices() async {
    emit(GetAllServicesLoadingState());
    Either<Failure, AllServicesEntity> response =
        await allServicesUsecase(AllClinicsEndpointParams(
      endpoint: endpoint,
      sortBy: sortBy,
      categoryId: categoryId,
      clinicId: clinicId,
    ));
    refreshController.refreshCompleted();
    refreshVendorController.refreshCompleted();

    emit(response.fold(
        (failure) => GetAllServicesErrorState(message: failure.message),
        (allClinicsEntity) =>
            GetAllServicesSuccessState(allClinicsEntity: allClinicsEntity)));
  }
}
