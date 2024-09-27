import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/general_entities/create_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reviews_entity.dart';
import '../repositories/reviews_repository.dart';

class ReviewsUsecase implements UseCase<ReviewsEntity, ReviewsParams> {
  final ReviewsRepository reviewsRepository;

  ReviewsUsecase(this.reviewsRepository);

  @override
  Future<Either<Failure, ReviewsEntity>> call(ReviewsParams params) =>
      reviewsRepository.reviews(params);
}

class CreateReviewsUsecase
    implements UseCase<CreateEntity, CreateReviewsParams> {
  final ReviewsRepository reviewsRepository;

  CreateReviewsUsecase(this.reviewsRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(CreateReviewsParams params) =>
      reviewsRepository.createReviews(params);
}
