import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/states_entity.dart';
import '../../../domain/use_cases/bank_usecase.dart';
import 'states_state.dart';

class StatesCubit extends Cubit<StatesState> {
  final StatesUsecase statesUsecase;
  StatesCubit({required this.statesUsecase}) : super(StatesInitial());

  static StatesCubit get(context) => BlocProvider.of(context);

  Future<void> getStatesFun() async {
    emit(GetStatesLoadingState());

    Either<Failure, StatesEntity> response = await statesUsecase(NoParams());

    emit(response
        .fold((failure) => GetStatesErrorState(message: failure.message),
            (statesEntity) {
      return GetStatesSuccessState(statesEntity: statesEntity);
    }));
  }
}
