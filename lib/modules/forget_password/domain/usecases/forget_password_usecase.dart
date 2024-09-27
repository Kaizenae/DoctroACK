import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/forget_password/domain/repositories/forget_password_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/general_entity.dart';

class SendOTPUsecase implements UseCase<GeneralEntity, StringParams> {
  final ForgetPasswordRepository forgetPasswordRepository;

  SendOTPUsecase(this.forgetPasswordRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(StringParams params) =>
      forgetPasswordRepository.sendOtp(params);
}

class VerifyOTPUsecase implements UseCase<GeneralEntity, StringParams> {
  final ForgetPasswordRepository forgetPasswordRepository;

  VerifyOTPUsecase(this.forgetPasswordRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(StringParams params) =>
      forgetPasswordRepository.verifyOtp(params);
}

class NewPasswordUsecase implements UseCase<GeneralEntity, NewPasswordParams> {
  final ForgetPasswordRepository forgetPasswordRepository;

  NewPasswordUsecase(this.forgetPasswordRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(NewPasswordParams params) =>
      forgetPasswordRepository.newPassword(params);
}
