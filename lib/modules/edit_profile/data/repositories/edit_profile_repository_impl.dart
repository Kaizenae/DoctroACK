import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/edit_profile_repository.dart';
import '../data_sources/edit_profile_remote_datasource.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final NetworkInfo networkInfo;
  final EditProfileRemoteDataSource editProfileRemoteDataSource;

  EditProfileRepositoryImpl(
      {required this.networkInfo, required this.editProfileRemoteDataSource});

  @override
  Future<Either<Failure, GeneralEntity>> editProfile(
      EditProfileParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await editProfileRemoteDataSource.editProfile(
          image: params.image,
          userName: params.userName,
          phoneNumber: params.phoneNumber,
          email: params.email,
        );
        if (remoteEmployee.generalEntity.status) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, remoteEmployee.generalEntity.message));
        }
      } catch (error) {
        if (kDebugMode) {
          print('errrrrrrrrrr $error');
        }
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
            await editProfileRemoteDataSource.deleteUserAccount();
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
