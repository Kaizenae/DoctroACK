import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/domain/entities/bank_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/clinic_profile_entity.dart';
import '../repositories/clinic_profile_repository.dart';

class ClinicProfileUsecase implements UseCase<ClinicProfileEntity, NoParams> {
  final ClinicProfileRepository clinicRepository;

  ClinicProfileUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, ClinicProfileEntity>> call(NoParams params) =>
      clinicRepository.clinicProfile(params);
}

class BankUsecase implements UseCase<BankEntity, NoParams> {
  final ClinicProfileRepository clinicRepository;

  BankUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, BankEntity>> call(NoParams params) =>
      clinicRepository.bank(params);
}

class EditClinicProfileUsecase
    implements UseCase<CreateEntity, EditClinicProfileParams> {
  final ClinicProfileRepository clinicRepository;

  EditClinicProfileUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(EditClinicProfileParams params) =>
      clinicRepository.editClinicProfile(params);
}
