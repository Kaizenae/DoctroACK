import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final NetworkInfo networkInfo;
  final WalletRemoteDataSource walletRemoteDataSource;

  WalletRepositoryImpl(
      {required this.networkInfo, required this.walletRemoteDataSource});

  @override
  Future<Either<Failure, WalletEntity>> wallet(noParams) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWallet = await walletRemoteDataSource.wallet();
        if (remoteWallet.resultEntity.status) {
          return Right(remoteWallet);
        } else {
          return Left(Failure(400, 'Get Wallet Error'));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
