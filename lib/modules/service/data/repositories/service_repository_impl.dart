import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../data_sources/service_remote_datasource.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final NetworkInfo networkInfo;
  final ServiceRemoteDataSource clinicRemoteDataSource;

  ServiceRepositoryImpl(
      {required this.networkInfo, required this.clinicRemoteDataSource});

  @override
  Future<Either<Failure, ServiceEntity>> service(ClinicParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic =
            await clinicRemoteDataSource.service(clinicID: params.clinicID);
        if (remoteClinic.resultEntity.status == true) {
          return Right(remoteClinic);
        } else {
          return Left(Failure(400, remoteClinic.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
