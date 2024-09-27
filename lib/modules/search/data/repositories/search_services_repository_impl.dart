import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/search_services_entity.dart';
import '../../domain/repositories/search_services_repository.dart';
import '../data_sources/search_services_remote_datasource.dart';

class SearchServicesRepositoryImpl implements SearchServicesRepository {
  final NetworkInfo networkInfo;
  final SearchServicesRemoteDataSource allClinicsRemoteDataSource;

  SearchServicesRepositoryImpl(
      {required this.networkInfo, required this.allClinicsRemoteDataSource});

  @override
  Future<Either<Failure, SearchServicesEntity>> searchServices(
      StringParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await allClinicsRemoteDataSource.searchServices(
            keyWord: params.string);
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
