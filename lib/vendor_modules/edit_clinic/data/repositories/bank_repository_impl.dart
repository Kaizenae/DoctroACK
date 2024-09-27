import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/domain/entities/banks_entity.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/states_entity.dart';
import '../../domain/repositories/bank_repository.dart';
import '../data_sources/bank_remote_datasource.dart';

class BankRepositoryImpl implements BankRepository {
  final NetworkInfo networkInfo;
  final BankRemoteDataSource currencyRemoteDataSource;

  BankRepositoryImpl(
      {required this.networkInfo, required this.currencyRemoteDataSource});

  @override
  Future<Either<Failure, CurrencyEntity>> currency(params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await currencyRemoteDataSource.currency();
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

  @override
  Future<Either<Failure, StatesEntity>> states(params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await currencyRemoteDataSource.states();
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

  @override
  Future<Either<Failure, BanksEntity>> banks(NoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await currencyRemoteDataSource.banks();
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

  @override
  Future<Either<Failure, CreateEntity>> editBank(EditBankParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await currencyRemoteDataSource.editBank(
          bankId: params.bankId,
          holderName: params.holderName,
          accountNumber: params.accountNumber,
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
