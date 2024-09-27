import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/available_times_entity.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/check_payment_entity.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/clinic_services_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/clinic_entity.dart';
import '../../domain/repositories/clinic_repository.dart';
import '../data_sources/clinic_remote_datasource.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final NetworkInfo networkInfo;
  final ClinicRemoteDataSource clinicRemoteDataSource;

  ClinicRepositoryImpl(
      {required this.networkInfo, required this.clinicRemoteDataSource});

  @override
  Future<Either<Failure, ClinicEntity>> clinic(ClinicParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic =
            await clinicRemoteDataSource.clinic(clinicID: params.clinicID);
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

  @override
  Future<Either<Failure, ClinicServicesEntity>> clinicServices(
      ClinicParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.clinicServices(
            clinicID: params.clinicID);
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

  @override
  Future<Either<Failure, AvailableTimesEntity>> availableTimes(
      AvailableTimesParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.availableTimes(
            serviceID: params.serviceID,
            date: params.date,
            doctorID: params.doctorID);
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

  @override
  Future<Either<Failure, CreateEntity>> createReservationOrder(
      CreateReservationOrderParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic =
            await clinicRemoteDataSource.createReservationOrder(
          serviceID: params.serviceID,
          wallet: params.wallet,
          date: params.date,
          start: params.start,
          state: params.state,
          userID: params.userID,
          transId: params.transId,
        );
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

  @override
  Future<Either<Failure, CheckPaymentEntity>> checkPayment(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.checkPayment();
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
