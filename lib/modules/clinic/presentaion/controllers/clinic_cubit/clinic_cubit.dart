import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/clinic_entity.dart';
import '../../../domain/use_cases/clinic_usecase.dart';
import 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  final ClinicUsecase clinicUsecase;

  ClinicCubit({required this.clinicUsecase}) : super(ClinicInitial());

  static ClinicCubit get(context) => BlocProvider.of(context);
  bool isPressed = false;
  int value = 1;

  int clinicID = 0;

  Future<void> getClinic() async {
    emit(GetClinicLoadingState());
    Either<Failure, ClinicEntity> response =
        await clinicUsecase(ClinicParams(clinicID: clinicID));

    emit(response.fold(
        (failure) => GetClinicErrorState(message: failure.message),
        (allClinicsEntity) =>
            GetClinicSuccessState(clinicEntity: allClinicsEntity)));
  }
}
