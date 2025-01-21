import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/general_entity.dart';
import '../../domain/repositories/forget_password_repository.dart';
import '../datasources/forget_password_datasource.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final NetworkInfo networkInfo;
  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  ForgetPasswordRepositoryImpl(
      {required this.networkInfo,
      required this.forgetPasswordRemoteDataSource});

  @override
  Future<Either<Failure, GeneralEntity>> sendOtp(forgetPasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForgetPassword = await forgetPasswordRemoteDataSource
            .sendOTP(email: forgetPasswordParams.string);
        if (remoteForgetPassword.generalEntity.status == true) {
          // await  forgetPasswordLocalDataSource.cacheForgetPassword(remoteForgetPassword);
          return Right(remoteForgetPassword);
        } else {
          return Left(Failure(400, remoteForgetPassword.generalEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> newPassword(
      NewPasswordParams forgetPasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForgetPassword =
            await forgetPasswordRemoteDataSource.newPassword(
                newPassword: forgetPasswordParams.newPassword,
                email: forgetPasswordParams.email);
        if (remoteForgetPassword.generalEntity.status == true) {
          // await  forgetPasswordLocalDataSource.cacheForgetPassword(remoteForgetPassword);
          return Right(remoteForgetPassword);
        } else {
          return Left(Failure(400, remoteForgetPassword.generalEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> verifyOtp(
    StringParams forgetPasswordParams,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteForgetPassword =
            await forgetPasswordRemoteDataSource.verifyOTP(
                otp: forgetPasswordParams.string,
                email: forgetPasswordParams.email);
        if (remoteForgetPassword.generalEntity.status == true) {
          // await  forgetPasswordLocalDataSource.cacheForgetPassword(remoteForgetPassword);
          return Right(remoteForgetPassword);
        } else {
          return Left(Failure(400, remoteForgetPassword.generalEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
