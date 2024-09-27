import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../../domain/repositories/change_password_repository.dart';
import '../datasources/change_password_datasource.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final NetworkInfo networkInfo;
  final ChangePasswordRemoteDataSource changePasswordRemoteDataSource;

  ChangePasswordRepositoryImpl(
      {required this.networkInfo,
      required this.changePasswordRemoteDataSource});

  @override
  Future<Either<Failure, GeneralEntity>> changePassword(
      ChangePasswordParams changePasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChangePassword =
            await changePasswordRemoteDataSource.changePassword(
                oldPassword: changePasswordParams.oldPassword,
                newPassword: changePasswordParams.newPassword);
        if (remoteChangePassword.generalEntity.status == true) {
          // await  ChangePasswordLocalDataSource.cacheChangePassword(remoteChangePassword);
          return Right(remoteChangePassword);
        } else {
          return Left(Failure(400, remoteChangePassword.generalEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
