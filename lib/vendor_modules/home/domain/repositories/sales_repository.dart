import 'package:dartz/dartz.dart';
import '../../domain/entities/sales_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

abstract class SalesRepository {
  Future<Either<Failure, SalesEntity>> sales(SalesParams params);
}
