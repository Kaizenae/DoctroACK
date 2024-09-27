import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/bank_entity.dart';
import '../../../domain/use_cases/clinic_profile_usecase.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  final BankUsecase bankUsecase;
  BankCubit({
    required this.bankUsecase,
  }) : super(BankInitial());
  static BankCubit get(context) => BlocProvider.of(context);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future<void> getBank() async {
    emit(BankLoadingState());
    Either<Failure, BankEntity> response = await bankUsecase(NoParams());
    refreshController.refreshCompleted();

    emit(response.fold((failure) => BankErrorState(message: failure.message),
        (bankEntity) => BankSuccessState(bankEntity: bankEntity)));
  }
}
