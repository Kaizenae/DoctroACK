import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/users_management/domain/entities/customers_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/users_entity.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_remote_datasource.dart';

class UsersRepositoryImpl implements UsersRepository {
  final NetworkInfo networkInfo;
  final UsersRemoteDataSource profileRemoteDataSource;

  UsersRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, UsersEntity>> users(noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.users();
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CustomersEntity>> customers(noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.customers();
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateEntity>> changeUserRole(
      UserParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.changeUserRole(
            userId: params.userID, role: params.role!);
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateEntity>> deleteUsers(UserParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile =
            await profileRemoteDataSource.deleteUser(userId: params.userID);
        if (remoteProfile.resultEntity.status) {
          return Right(remoteProfile);
        } else {
          return Left(Failure(400, 'Get Profile Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
