import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_services_entity.dart';
import '../repositories/search_services_repository.dart';

class SearchServicesUsecase
    implements UseCase<SearchServicesEntity, StringParams> {
  final SearchServicesRepository allClinicsRepository;

  SearchServicesUsecase(this.allClinicsRepository);

  @override
  Future<Either<Failure, SearchServicesEntity>> call(StringParams params) =>
      allClinicsRepository.searchServices(params);
}
