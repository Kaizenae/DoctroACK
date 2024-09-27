part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  @override
  List<Object> get props => [];
}

class GetReviewsLoadingState extends ReviewsState {
  @override
  List<Object> get props => [];
}

class GetReviewsSuccessState extends ReviewsState {
  final ReviewsEntity reviewsEntity;

  const GetReviewsSuccessState({required this.reviewsEntity});

  @override
  List<Object> get props => [reviewsEntity];
}

class GetReviewsErrorState extends ReviewsState {
  final String message;

  const GetReviewsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SelectSortLoadingState extends ReviewsState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends ReviewsState {
  @override
  List<Object> get props => [];
}
