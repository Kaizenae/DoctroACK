import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/edit_service_repository.dart';

class EditServiceUsecase implements UseCase<CreateEntity, EditServiceParams> {
  final EditServiceRepository editServiceRepository;

  EditServiceUsecase(this.editServiceRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(EditServiceParams params) =>
      editServiceRepository.editService(params);
}
