import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favourite_entity.dart';
import '../repositories/favourite_repository.dart';

class FavouriteUsecase implements UseCase<FavouriteEntity, NoParams> {
  final FavouriteRepository favouriteRepository;

  FavouriteUsecase(this.favouriteRepository);

  @override
  Future<Either<Failure, FavouriteEntity>> call(NoParams params) =>
      favouriteRepository.favourite(params);
}

class AddRemoveFavouriteUsecase
    implements UseCase<CreateEntity, FavouriteParams> {
  final FavouriteRepository favouriteRepository;

  AddRemoveFavouriteUsecase(this.favouriteRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(FavouriteParams params) =>
      favouriteRepository.addRemoveFavourite(params);
}
