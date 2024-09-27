import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class ServiceUsecase implements UseCase<ServiceEntity, ClinicParams> {
  final ServiceRepository clinicRepository;

  ServiceUsecase(this.clinicRepository);

  @override
  Future<Either<Failure, ServiceEntity>> call(ClinicParams params) =>
      clinicRepository.service(params);
}
