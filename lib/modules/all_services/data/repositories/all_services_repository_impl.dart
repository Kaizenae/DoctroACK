import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/all_services_entity.dart';
import '../../domain/repositories/all_services_repository.dart';
import '../data_sources/all_services_remote_datasource.dart';

class AllServicesRepositoryImpl implements AllServicesRepository {
  final NetworkInfo networkInfo;
  final AllServicesRemoteDataSource allClinicsRemoteDataSource;

  AllServicesRepositoryImpl(
      {required this.networkInfo, required this.allClinicsRemoteDataSource});

  @override
  Future<Either<Failure, AllServicesEntity>> allServices(
      AllClinicsEndpointParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await allClinicsRemoteDataSource.allClinics(
          endpoint: params.endpoint,
          categoryId: params.categoryId ?? 0,
          clinicId: params.clinicId ?? 0,
          sortBy: params.sortBy ?? '',
        );
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
