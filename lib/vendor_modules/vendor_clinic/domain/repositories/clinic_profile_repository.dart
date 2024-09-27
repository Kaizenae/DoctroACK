import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/domain/entities/bank_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/clinic_profile_entity.dart';

abstract class ClinicProfileRepository {
  Future<Either<Failure, ClinicProfileEntity>> clinicProfile(NoParams params);
  Future<Either<Failure, BankEntity>> bank(NoParams params);
  Future<Either<Failure, CreateEntity>> editClinicProfile(
      EditClinicProfileParams params);
}
