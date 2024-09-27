import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> profile(noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.profile();
        if (remoteProfile.resultEntity.status == 200) {
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
