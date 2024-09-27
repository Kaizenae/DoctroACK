import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../languages/locale_keys.g.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/all_clinics/domain/entities/all_clinics_entity.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/use_cases/all_clinics_usecase.dart';

part 'all_clinics_state.dart';

class AllClinicsCubit extends Cubit<AllClinicsState> {
  final AllClinicsUsecase allClinicsUsecase;

  AllClinicsCubit({required this.allClinicsUsecase}) : super(ClinicInitial());

  static AllClinicsCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String sortValue = '';
  int sortCalendarValue = 1;
  int filterValue = 0;
  double lat = 0.0;
  double long = 0.0;

  List<Map<String, dynamic>> sortClinicModel = [
    {"name": LocaleKeys.nearby, "id": 'nearby'},
    {"name": LocaleKeys.newest, "id": 'newest'},
    {"name": LocaleKeys.oldest, "id": 'oldest'},
    {"name": LocaleKeys.highRate, "id": 'high_rating'},
  ];

  selectSort(String val) {
    emit(SelectSortLoadingState());
    sortValue = val;
    emit(SelectSortState());
  }

  clearSort() {
    sortValue = '';
    filterValue = 0;
    lat = 0.0;
    long = 0.0;
    emit(ClearSortState());
  }

  selectCalendarSort(int val) {
    emit(SelectSortLoadingState());
    sortCalendarValue = val;
    emit(SelectSortState());
  }

  selectFilter(int val) {
    emit(SelectFilterLoadingState());
    filterValue = val;
    emit(SelectFilterState());
  }

  String endpoint = EndPoints.getAllClinicsEndpoint;

  Future<void> getAllClinics() async {
    emit(GetAllClinicsLoadingState());
    Either<Failure, AllClinicsEntity> response = await allClinicsUsecase(
        AllClinicsEndpointParams(
            lat: lat,
            long: long,
            sortBy: sortValue,
            endpoint: endpoint,
            tagId: filterValue));
    refreshController.refreshCompleted();

    emit(response.fold(
        (failure) => GetAllClinicsErrorState(message: failure.message),
        (allClinicsEntity) =>
            GetAllClinicsSuccessState(allClinicsEntity: allClinicsEntity)));
  }
}
