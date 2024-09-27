import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repository.dart';

class CategoriesUsecase implements UseCase<CategoriesEntity, NoParams> {
  final CategoriesRepository categoriesRepository;

  CategoriesUsecase(this.categoriesRepository);

  @override
  Future<Either<Failure, CategoriesEntity>> call(NoParams params) =>
      categoriesRepository.categories(params);
}
