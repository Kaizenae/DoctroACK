import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/offer_entity.dart';
import '../../../domain/use_cases/offer_usecase.dart';
import 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final OfferUsecase offerUsecase;
  OfferCubit({
    required this.offerUsecase,
  }) : super(OfferInitial());

  static OfferCubit get(context) => BlocProvider.of(context);

  Future<void> getOffer() async {
    emit(GetOfferLoadingState());
    Either<Failure, OfferEntity> response = await offerUsecase(NoParams());

    emit(response.fold(
        (failure) => GetOfferErrorState(message: failure.message),
        (allOffersEntity) =>
            GetOfferSuccessState(offerEntity: allOffersEntity)));
  }
}
