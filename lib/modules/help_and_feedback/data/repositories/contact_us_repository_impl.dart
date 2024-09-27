import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/contact_us_repository.dart';
import '../data_sources/contact_us_remote_datasource.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {
  final NetworkInfo networkInfo;
  final ContactUsRemoteDataSource contactUsRemoteDataSource;

  ContactUsRepositoryImpl(
      {required this.networkInfo, required this.contactUsRemoteDataSource});

  @override
  Future<Either<Failure, GeneralEntity>> contactUs(
      ContactUsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await contactUsRemoteDataSource.contactUs(
          name: params.name,
          message: params.message,
          email: params.email,
          subject: params.subject,
        );
        if (remoteEmployee.generalEntity.status) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, remoteEmployee.generalEntity.message));
        }
      } catch (error) {
        if (kDebugMode) {
          print('errrrrrrrrrr $error');
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
