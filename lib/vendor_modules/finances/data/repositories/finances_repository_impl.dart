import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/finances_entity.dart';
import '../../domain/repositories/finances_repository.dart';
import '../data_sources/finances_remote_datasource.dart';

class FinancesRepositoryImpl implements FinancesRepository {
  final NetworkInfo networkInfo;
  final FinancesRemoteDataSource financesRemoteDataSource;

  FinancesRepositoryImpl(
      {required this.networkInfo, required this.financesRemoteDataSource});

  @override
  Future<Either<Failure, FinancesEntity>> finances(noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await financesRemoteDataSource.finances();
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
