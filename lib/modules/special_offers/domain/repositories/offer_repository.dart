import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/offer_entity.dart';

abstract class OfferRepository {
  Future<Either<Failure, OfferEntity>> offers(NoParams params);
}
