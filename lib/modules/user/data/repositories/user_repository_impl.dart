import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/notification_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(
      {required this.networkInfo, required this.userRemoteDataSource});

  @override
  Future<Either<Failure, GeneralEntity>> updateNoToken(
      StringParams userParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChangePassword = await userRemoteDataSource.updateNoToken(
          noToken: userParams.string,
        );
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

  @override
  Future<Either<Failure, NotificationEntity>> sendNotification(
      SendNotificationParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChangePassword =
            await userRemoteDataSource.sendNotification(
                title: params.title,
                body: params.body,
                toToken: params.toToken);
        if (remoteChangePassword.success == 1) {
          // await  ChangePasswordLocalDataSource.cacheChangePassword(remoteChangePassword);
          return Right(remoteChangePassword);
        } else {
          return Left(Failure(400, 'Token not valid'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> deleteUserAccount(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChangePassword =
            await userRemoteDataSource.deleteUserAccount();
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
