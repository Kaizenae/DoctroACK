import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/categories/domain/entities/categories_entity.dart';

import '../../../../core/error/failure.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CategoriesEntity>> categories(NoParams params);
}
