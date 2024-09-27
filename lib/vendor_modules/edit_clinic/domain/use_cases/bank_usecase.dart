import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/general_entities/create_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/banks_entity.dart';
import '../entities/currency_entity.dart';
import '../entities/states_entity.dart';
import '../repositories/bank_repository.dart';

class CurrencyUsecase implements UseCase<CurrencyEntity, NoParams> {
  final BankRepository bankRepository;

  CurrencyUsecase(this.bankRepository);

  @override
  Future<Either<Failure, CurrencyEntity>> call(NoParams params) =>
      bankRepository.currency(params);
}

class StatesUsecase implements UseCase<StatesEntity, NoParams> {
  final BankRepository bankRepository;

  StatesUsecase(this.bankRepository);

  @override
  Future<Either<Failure, StatesEntity>> call(NoParams params) =>
      bankRepository.states(params);
}

class BanksUsecase implements UseCase<BanksEntity, NoParams> {
  final BankRepository bankRepository;

  BanksUsecase(this.bankRepository);

  @override
  Future<Either<Failure, BanksEntity>> call(NoParams params) =>
      bankRepository.banks(params);
}

class EditBankUsecase implements UseCase<CreateEntity, EditBankParams> {
  final BankRepository bankRepository;

  EditBankUsecase(this.bankRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(EditBankParams params) =>
      bankRepository.editBank(params);
}
