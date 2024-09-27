import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/banks_entity.dart';
import '../../../domain/use_cases/bank_usecase.dart';
import 'banks_state.dart';

class BanksCubit extends Cubit<BanksState> {
  final BanksUsecase banksUsecase;
  BanksCubit({required this.banksUsecase}) : super(BanksInitial());

  static BanksCubit get(context) => BlocProvider.of(context);

  Future<void> getBanksFun() async {
    emit(GetBanksLoadingState());

    Either<Failure, BanksEntity> response = await banksUsecase(NoParams());

    emit(response
        .fold((failure) => GetBanksErrorState(message: failure.message),
            (banksEntity) {
      return GetBanksSuccessState(banksEntity: banksEntity);
    }));
  }
}
