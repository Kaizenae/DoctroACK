import 'package:dartz/dartz.dart';
import '../../domain/entities/finances_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class FinancesRepository {
  Future<Either<Failure, FinancesEntity>> finances(NoParams params);
}
