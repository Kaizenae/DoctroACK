import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/finances_entity.dart';
import '../repositories/finances_repository.dart';

class FinancesUsecase implements UseCase<FinancesEntity, NoParams> {
  final FinancesRepository financesRepository;

  FinancesUsecase(this.financesRepository);

  @override
  Future<Either<Failure, FinancesEntity>> call(NoParams params) =>
      financesRepository.finances(params);
}
