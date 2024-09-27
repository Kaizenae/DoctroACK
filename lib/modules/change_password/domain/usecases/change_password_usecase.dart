import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../repositories/change_password_repository.dart';

class ChangePasswordUsecase
    implements UseCase<GeneralEntity, ChangePasswordParams> {
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUsecase(this.changePasswordRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(ChangePasswordParams params) =>
      changePasswordRepository.changePassword(params);
}
