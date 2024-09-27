import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/appointments_entity.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../data_sources/appointments_remote_datasource.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final NetworkInfo networkInfo;
  final AppointmentsRemoteDataSource appointmentsRemoteDataSource;

  AppointmentsRepositoryImpl(
      {required this.networkInfo, required this.appointmentsRemoteDataSource});

  @override
  Future<Either<Failure, AppointmentsEntity>> appointments(params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await appointmentsRemoteDataSource.appointments(
          end: params.end,
          filter: params.filter,
          start: params.start,
          serviceId: params.serviceId,
        );
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
