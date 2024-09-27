import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/domain/entities/bank_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/clinic_profile_entity.dart';
import '../../domain/repositories/clinic_profile_repository.dart';
import '../data_sources/clinic_profile_remote_datasource.dart';

class ClinicProfileRepositoryImpl implements ClinicProfileRepository {
  final NetworkInfo networkInfo;
  final ClinicProfileRemoteDataSource clinicRemoteDataSource;

  ClinicProfileRepositoryImpl(
      {required this.networkInfo, required this.clinicRemoteDataSource});

  @override
  Future<Either<Failure, ClinicProfileEntity>> clinicProfile(
      NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.clinicProfile();
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
  Future<Either<Failure, CreateEntity>> editClinicProfile(
      EditClinicProfileParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.editClinicProfile(
            logo: params.logo,
            cover: params.cover,
            name: params.name,
            street: params.street,
            city: params.city,
            stateId: params.stateId,
            phoneNumber: params.phoneNumber,
            expertise: params.expertise,
            experience: params.experience,
            about: params.about);
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
  Future<Either<Failure, BankEntity>> bank(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await clinicRemoteDataSource.bank();
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
