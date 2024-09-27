import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/all_clinics/domain/entities/tags_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/all_clinics_entity.dart';
import '../../domain/repositories/all_clinics_repository.dart';
import '../data_sources/all_clinics_remote_datasource.dart';

class AllClinicsRepositoryImpl implements AllClinicsRepository {
  final NetworkInfo networkInfo;
  final AllClinicsRemoteDataSource allClinicsRemoteDataSource;

  AllClinicsRepositoryImpl(
      {required this.networkInfo, required this.allClinicsRemoteDataSource});

  @override
  Future<Either<Failure, AllClinicsEntity>> allClinics(
      AllClinicsEndpointParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await allClinicsRemoteDataSource.allClinics(
            tagId: params.tagId ?? 0,
            sortBy: params.sortBy ?? '',
            lat: params.lat ?? 0.0,
            long: params.long ?? 0.0,
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

  @override
  Future<Either<Failure, TagsEntity>> tags(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await allClinicsRemoteDataSource.tags();
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
