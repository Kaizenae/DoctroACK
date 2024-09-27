import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offer_repository.dart';
import '../data_sources/offer_remote_datasource.dart';

class OfferRepositoryImpl implements OfferRepository {
  final NetworkInfo networkInfo;
  final OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl(
      {required this.networkInfo, required this.offerRemoteDataSource});

  @override
  Future<Either<Failure, OfferEntity>> offers(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEmployee = await offerRemoteDataSource.offers();
        return Right(remoteEmployee);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
