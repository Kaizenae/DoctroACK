import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/currency_entity.dart';
import '../../../domain/use_cases/bank_usecase.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyUsecase currencyUsecase;
  CurrencyCubit({required this.currencyUsecase}) : super(CurrencyInitial());

  static CurrencyCubit get(context) => BlocProvider.of(context);

  Future<void> getCurrencyFun() async {
    emit(GetCurrencyLoadingState());

    Either<Failure, CurrencyEntity> response =
        await currencyUsecase(NoParams());

    emit(response
        .fold((failure) => GetCurrencyErrorState(message: failure.message),
            (currencyEntity) {
      return GetCurrencySuccessState(currencyEntity: currencyEntity);
    }));
  }
}
