import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/clinic_services_entity.dart';
import '../../../domain/use_cases/clinic_usecase.dart';
import 'clinic_services_state.dart';

class ClinicServicesCubit extends Cubit<ClinicServicesState> {
  final ClinicServicesUsecase clinicServicesUsecase;

  ClinicServicesCubit({required this.clinicServicesUsecase})
      : super(ClinicInitial());

  static ClinicServicesCubit get(context) => BlocProvider.of(context);

  int clinicID = 0;

  Future<void> getClinicServices() async {
    emit(GetClinicServicesLoadingState());
    Either<Failure, ClinicServicesEntity> response =
        await clinicServicesUsecase(ClinicParams(clinicID: clinicID));

    emit(response.fold(
        (failure) => GetClinicServicesErrorState(message: failure.message),
        (clinicEntity) =>
            GetClinicServicesSuccessState(clinicEntity: clinicEntity)));
  }

  imageConverter(String image) {
    return const Base64Decoder().convert(image);
  }

  int value = 1;

  selectService(int val) {
    emit(SelectServiceLoadingState());
    value = val;
    emit(SelectServiceState());
  }
}
