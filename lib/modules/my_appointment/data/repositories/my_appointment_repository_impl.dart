import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/my_appointment_entity.dart';
import '../../domain/repositories/my_appointment_repository.dart';
import '../data_sources/my_appointment_remote_datasource.dart';

class MyAppointmentRepositoryImpl implements MyAppointmentRepository {
  final NetworkInfo networkInfo;
  final MyAppointmentRemoteDataSource myAppointmentRemoteDataSource;

  MyAppointmentRepositoryImpl(
      {required this.networkInfo, required this.myAppointmentRemoteDataSource});

  @override
  Future<Either<Failure, MyAppointmentEntity>> myAppointment(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee =
            await myAppointmentRemoteDataSource.myAppointment();
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
  Future<Either<Failure, CreateEntity>> cancelAppointment(
      CancelAppointmentParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await myAppointmentRemoteDataSource
            .cancelAppointment(id: params.id, reason: params.reason);
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
  Future<Either<Failure, CreateEntity>> changeAppointment(
      ChangeAppointmentParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee =
            await myAppointmentRemoteDataSource.changeAppointment(
                id: params.id, date: params.date, time: params.time);
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
  Future<Either<Failure, UserAppointmentEntity>> appointment(
      IDParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee =
            await myAppointmentRemoteDataSource.appointment(id: params.id);
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
