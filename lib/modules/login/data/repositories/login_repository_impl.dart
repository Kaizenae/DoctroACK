import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/strings_manager.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';
import '../datasources/login_local_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  LoginRepositoryImpl(
      {required this.loginLocalDataSource,
      required this.networkInfo,
      required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await loginRemoteDataSource.login(
          email: loginParams.email,
          password: loginParams.password,
        );

        if (remoteLogin.resultEntity.status == true) {
          await CacheHelper.put(
              key: AppStrings.cachedToken,
              value: remoteLogin.resultEntity.body.token);
          await CacheHelper.put(
              key: AppStrings.cachedExpireToken,
              value: remoteLogin.resultEntity.body.expireToken);
          await CacheHelper.put(
              key: AppStrings.cachedType,
              value: remoteLogin.resultEntity.body.type);
          await CacheHelper.put(
              key: AppStrings.cachedRole,
              value: remoteLogin.resultEntity.body.role);
          await CacheHelper.put(
              key: AppStrings.cachedID,
              value: remoteLogin.resultEntity.body.type == 'patient'
                  ? 0
                  : remoteLogin.resultEntity.body.partnerId);

          AppConstants.token =
              await CacheHelper.get(key: AppStrings.cachedToken);
          AppConstants.expireToken =
              await CacheHelper.get(key: AppStrings.cachedExpireToken);
          AppConstants.type = await CacheHelper.get(key: AppStrings.cachedType);
          AppConstants.role = await CacheHelper.get(key: AppStrings.cachedRole);
          AppConstants.cachedId =
              await CacheHelper.get(key: AppStrings.cachedID);

          return Right(remoteLogin);
        } else {
          return Left(Failure(400, remoteLogin.resultEntity.message));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
