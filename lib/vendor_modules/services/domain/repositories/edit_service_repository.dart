import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';

abstract class EditServiceRepository {
  Future<Either<Failure, CreateEntity>> editService(EditServiceParams params);
}
