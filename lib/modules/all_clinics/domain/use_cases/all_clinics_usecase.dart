import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/all_clinics_entity.dart';
import '../entities/tags_entity.dart';
import '../repositories/all_clinics_repository.dart';

class AllClinicsUsecase
    implements UseCase<AllClinicsEntity, AllClinicsEndpointParams> {
  final AllClinicsRepository allClinicsRepository;

  AllClinicsUsecase(this.allClinicsRepository);

  @override
  Future<Either<Failure, AllClinicsEntity>> call(
          AllClinicsEndpointParams params) =>
      allClinicsRepository.allClinics(params);
}

class TagsUsecase implements UseCase<TagsEntity, NoParams> {
  final AllClinicsRepository allClinicsRepository;

  TagsUsecase(this.allClinicsRepository);

  @override
  Future<Either<Failure, TagsEntity>> call(NoParams params) =>
      allClinicsRepository.tags(params);
}
