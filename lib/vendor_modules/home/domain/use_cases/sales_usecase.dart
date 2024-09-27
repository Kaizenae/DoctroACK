import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sales_entity.dart';
import '../repositories/sales_repository.dart';

class SalesUsecase implements UseCase<SalesEntity, SalesParams> {
  final SalesRepository salesRepository;

  SalesUsecase(this.salesRepository);

  @override
  Future<Either<Failure, SalesEntity>> call(SalesParams params) =>
      salesRepository.sales(params);
}
