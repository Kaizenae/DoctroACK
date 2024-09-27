import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/repositories/edit_service_repository.dart';
import '../data_sources/edit_service_remote_datasource.dart';

class EditServiceRepositoryImpl implements EditServiceRepository {
  final NetworkInfo networkInfo;
  final EditServiceRemoteDataSource editServiceRemoteDataSource;

  EditServiceRepositoryImpl(
      {required this.networkInfo, required this.editServiceRemoteDataSource});

  @override
  Future<Either<Failure, CreateEntity>> editService(
      EditServiceParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await editServiceRemoteDataSource.editService(
            serviceID: params.serviceId,
            name: params.name,
            about: params.about,
            price: params.price,
            logo: params.logo!);
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
