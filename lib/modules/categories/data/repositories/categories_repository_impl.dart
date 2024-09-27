import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../data_sources/categories_remote_datasource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final NetworkInfo networkInfo;
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImpl(
      {required this.networkInfo, required this.categoriesRemoteDataSource});

  @override
  Future<Either<Failure, CategoriesEntity>> categories(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await categoriesRemoteDataSource.categories();
        if (remoteEmployee.resultEntity.status == true) {
          return Right(remoteEmployee);
        } else {
          return Left(Failure(400, 'Get Employee Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
