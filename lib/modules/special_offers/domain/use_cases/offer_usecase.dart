import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class OfferUsecase implements UseCase<OfferEntity, NoParams> {
  final OfferRepository offerRepository;

  OfferUsecase(this.offerRepository);

  @override
  Future<Either<Failure, OfferEntity>> call(NoParams params) =>
      offerRepository.offers(params);
}
