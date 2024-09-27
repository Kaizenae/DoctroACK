import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/all_services_entity.dart';
import '../repositories/all_services_repository.dart';

class AllServicesUsecase
    implements UseCase<AllServicesEntity, AllClinicsEndpointParams> {
  final AllServicesRepository allClinicsRepository;

  AllServicesUsecase(this.allClinicsRepository);

  @override
  Future<Either<Failure, AllServicesEntity>> call(
          AllClinicsEndpointParams params) =>
      allClinicsRepository.allServices(params);
}
