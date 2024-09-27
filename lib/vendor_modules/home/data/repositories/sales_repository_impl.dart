import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sales_entity.dart';
import '../../domain/repositories/sales_repository.dart';
import '../data_sources/sales_remote_datasource.dart';

class SalesRepositoryImpl implements SalesRepository {
  final NetworkInfo networkInfo;
  final SalesRemoteDataSource salesRemoteDataSource;

  SalesRepositoryImpl(
      {required this.networkInfo, required this.salesRemoteDataSource});

  @override
  Future<Either<Failure, SalesEntity>> sales(params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await salesRemoteDataSource.sales(
          end: params.end,
          filter: params.filter,
          start: params.start,
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
