import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/general_entity.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, GeneralEntity>> sendOtp(StringParams params);
  Future<Either<Failure, GeneralEntity>> verifyOtp(StringParams params);
  Future<Either<Failure, GeneralEntity>> newPassword(NewPasswordParams params);
}
