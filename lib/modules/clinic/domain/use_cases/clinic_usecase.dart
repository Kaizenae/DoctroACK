import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/check_payment_entity.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/clinic_services_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/available_times_entity.dart';
import '../entities/clinic_entity.dart';
import '../repositories/clinic_repository.dart';

class CheckPaymentUsecase implements UseCase<CheckPaymentEntity, NoParams> {
  final ClinicRepository clinicRepository;

  CheckPaymentUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, CheckPaymentEntity>> call(NoParams params) =>
      clinicRepository.checkPayment(params);
}

class ClinicUsecase implements UseCase<ClinicEntity, ClinicParams> {
  final ClinicRepository clinicRepository;

  ClinicUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, ClinicEntity>> call(ClinicParams params) =>
      clinicRepository.clinic(params);
}

class ClinicServicesUsecase
    implements UseCase<ClinicServicesEntity, ClinicParams> {
  final ClinicRepository clinicRepository;

  ClinicServicesUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, ClinicServicesEntity>> call(ClinicParams params) =>
      clinicRepository.clinicServices(params);
}

class AvailableTimesUsecase
    implements UseCase<AvailableTimesEntity, AvailableTimesParams> {
  final ClinicRepository clinicRepository;

  AvailableTimesUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, AvailableTimesEntity>> call(
          AvailableTimesParams params) =>
      clinicRepository.availableTimes(params);
}

class CreateReservationOrderUsecase
    implements UseCase<CreateEntity, CreateReservationOrderParams> {
  final ClinicRepository clinicRepository;

  CreateReservationOrderUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(
          CreateReservationOrderParams params) =>
      clinicRepository.createReservationOrder(params);
}
