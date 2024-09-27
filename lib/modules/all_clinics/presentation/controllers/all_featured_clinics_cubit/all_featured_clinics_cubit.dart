import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/all_clinics/domain/entities/all_clinics_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/use_cases/all_clinics_usecase.dart';

part 'all_featured_clinics_state.dart';

class AllFeaturedClinicsCubit extends Cubit<AllFeaturedClinicsState> {
  final AllClinicsUsecase allClinicsUsecase;
  AllFeaturedClinicsCubit({required this.allClinicsUsecase})
      : super(ClinicInitial());
  static AllFeaturedClinicsCubit get(context) => BlocProvider.of(context);

  Future<void> getAllFeaturedClinics() async {
    emit(GetAllFeaturedClinicsLoadingState());
    Either<Failure, AllClinicsEntity> response = await allClinicsUsecase(
        const AllClinicsEndpointParams(
            endpoint: EndPoints.getAllFeaturedClinicsEndpoint));

    emit(response.fold(
        (failure) => GetAllFeaturedClinicsErrorState(message: failure.message),
        (allClinicsEntity) => GetAllFeaturedClinicsSuccessState(
            allClinicsEntity: allClinicsEntity)));
  }

  imageConverter(String image) {
    return const Base64Decoder().convert(image);
  }

  bool isPressed = false;
  int sortValue = 1;
  List<Map<String, dynamic>> sortModel = [
    {"name": "Newest", "id": 1},
    {"name": "Oldest", "id": 2},
    {
      "name": "High Rate",
      "id": 3,
    },
  ];

  selectSort(int val) {
    emit(SelectSortLoadingState());
    sortValue = val;
    emit(SelectSortState());
  }
}
