import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, GeneralEntity>> changePassword(
      ChangePasswordParams params);
}
