import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/repositories/block_time_repository.dart';
import '../data_sources/block_time_remote_datasource.dart';

class BlockTimeRepositoryImpl implements BlockTimeRepository {
  final NetworkInfo networkInfo;
  final BlockTimeRemoteDataSource blockTimeRemoteDataSource;

  BlockTimeRepositoryImpl(
      {required this.networkInfo, required this.blockTimeRemoteDataSource});

  @override
  Future<Either<Failure, CreateEntity>> blockTime(
      BlockTimeParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClinic = await blockTimeRemoteDataSource.blockTime(
          serviceID: params.serviceID,
          date: params.date,
          time: params.time,
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
}
