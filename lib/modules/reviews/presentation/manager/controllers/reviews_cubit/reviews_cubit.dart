import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/reviews_entity.dart';
import '../../../../domain/use_cases/reviews_usecase.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsUsecase reviewsUsecase;
  ReviewsCubit({required this.reviewsUsecase}) : super(ReviewsInitial());
  static ReviewsCubit get(context) => BlocProvider.of(context);

  int clinicID = 0;
  int serviceID = 0;
  int reviewsCount = 0;
  int filter = 5;
  String clinicRate = '0';
  String clinicName = '';
  bool isClinic = true;
  Future<void> getReviews() async {
    emit(GetReviewsLoadingState());
    Either<Failure, ReviewsEntity> response =
        await reviewsUsecase(ReviewsParams(
      clinicID: clinicID,
      isClinic: isClinic,
      filter: filter,
    ));

    emit(response.fold(
        (failure) => GetReviewsErrorState(message: failure.message),
        (reviewsEntity) =>
            GetReviewsSuccessState(reviewsEntity: reviewsEntity)));
  }
}
