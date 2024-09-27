import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/wallet_entity.dart';
import '../repositories/wallet_repository.dart';

class WalletUsecase implements UseCase<WalletEntity, NoParams> {
  final WalletRepository walletRepository;

  WalletUsecase(this.walletRepository);

  @override
  Future<Either<Failure, WalletEntity>> call(NoParams params) =>
      walletRepository.wallet(params);
}
