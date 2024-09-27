import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/domain/entities/banks_entity.dart';
import '../../domain/entities/currency_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/states_entity.dart';

abstract class BankRepository {
  Future<Either<Failure, CreateEntity>> editBank(EditBankParams params);
  Future<Either<Failure, CurrencyEntity>> currency(NoParams params);
  Future<Either<Failure, StatesEntity>> states(NoParams params);
  Future<Either<Failure, BanksEntity>> banks(NoParams params);
}
