import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/all_clinics_entity.dart';
import '../entities/tags_entity.dart';

abstract class AllClinicsRepository {
  Future<Either<Failure, AllClinicsEntity>> allClinics(
      AllClinicsEndpointParams params);
  Future<Either<Failure, TagsEntity>> tags(NoParams params);
}
