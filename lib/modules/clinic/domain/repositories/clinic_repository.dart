import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/clinic_services_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/available_times_entity.dart';
import '../entities/check_payment_entity.dart';
import '../entities/clinic_entity.dart';

abstract class ClinicRepository {
  Future<Either<Failure, CheckPaymentEntity>> checkPayment(NoParams params);

  Future<Either<Failure, ClinicEntity>> clinic(ClinicParams params);

  Future<Either<Failure, ClinicServicesEntity>> clinicServices(
      ClinicParams params);

  Future<Either<Failure, AvailableTimesEntity>> availableTimes(
      AvailableTimesParams params);

  Future<Either<Failure, CreateEntity>> createReservationOrder(
      CreateReservationOrderParams params);
}
