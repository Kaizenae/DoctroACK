import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/service_entity.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ServiceEntity>> service(ClinicParams params);
}
