import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/general_entities/create_entity.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/use_cases/reviews_usecase.dart';
import 'create_reviews_state.dart';

class CreateReviewsCubit extends Cubit<CreateReviewsState> {
  final CreateReviewsUsecase reviewsUsecase;

  CreateReviewsCubit({required this.reviewsUsecase})
      : super(CreateReviewsInitial());

  static CreateReviewsCubit get(context) => BlocProvider.of(context);

  int serviceID = 0;
  String rate = '3.0';
  TextEditingController note = TextEditingController();

  Future<void> createReviews() async {
    emit(CreateReviewsLoadingState());
    Either<Failure, CreateEntity> response = await reviewsUsecase(
        CreateReviewsParams(serviceID: serviceID, rate: rate, note: note.text));

    emit(response.fold(
        (failure) => CreateReviewsErrorState(message: failure.message),
        (createEntity) =>
            CreateReviewsSuccessState(createEntity: createEntity)));
  }
}
