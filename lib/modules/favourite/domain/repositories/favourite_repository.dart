import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/favourite_entity.dart';

abstract class FavouriteRepository {
  Future<Either<Failure, FavouriteEntity>> favourite(NoParams params);

  Future<Either<Failure, CreateEntity>> addRemoveFavourite(
      FavouriteParams params);
}
