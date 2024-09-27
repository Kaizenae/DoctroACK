import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/reviews_entity.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, ReviewsEntity>> reviews(ReviewsParams params);
  Future<Either<Failure, CreateEntity>> createReviews(
      CreateReviewsParams params);
}
