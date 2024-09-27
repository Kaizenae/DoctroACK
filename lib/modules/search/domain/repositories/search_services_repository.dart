import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/search_services_entity.dart';

abstract class SearchServicesRepository {
  Future<Either<Failure, SearchServicesEntity>> searchServices(
      StringParams params);
}
