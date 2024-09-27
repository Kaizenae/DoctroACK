import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/favourite_entity.dart';
import '../../domain/repositories/favourite_repository.dart';
import '../data_sources/favourite_remote_datasource.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final NetworkInfo networkInfo;
  final FavouriteRemoteDataSource favouriteRemoteDataSource;

  FavouriteRepositoryImpl(
      {required this.networkInfo, required this.favouriteRemoteDataSource});

  @override
  Future<Either<Failure, FavouriteEntity>> favourite(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await favouriteRemoteDataSource.favourite();
        return Right(remoteEmployee);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, CreateEntity>> addRemoveFavourite(
      FavouriteParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee =
            await favouriteRemoteDataSource.addRemoveFavourite(
                id: params.id,
                isClinic: params.isClinic,
                endpoint: params.endpoint);
        if (remoteEmployee.resultEntity.status == true) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, remoteEmployee.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
