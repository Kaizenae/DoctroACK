import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/all_services_entity.dart';

abstract class AllServicesRepository {
  Future<Either<Failure, AllServicesEntity>> allServices(
      AllClinicsEndpointParams params);
}
