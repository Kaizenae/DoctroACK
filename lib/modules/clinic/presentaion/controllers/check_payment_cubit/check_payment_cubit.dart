import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/clinic/domain/entities/check_payment_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/clinic_usecase.dart';

part 'check_payment_state.dart';

class CheckPaymentCubit extends Cubit<CheckPaymentState> {
  final CheckPaymentUsecase checkPaymentUsecase;

  CheckPaymentCubit({required this.checkPaymentUsecase})
      : super(CheckPaymentInitial());

  static CheckPaymentCubit get(context) => BlocProvider.of(context);

  Future<void> checkPaymentStatus() async {
    emit(CheckPaymentLoadingState());
    Either<Failure, CheckPaymentEntity> response =
        await checkPaymentUsecase(NoParams());

    emit(response.fold(
        (failure) => CheckPaymentErrorState(message: failure.message),
        (checkPaymentEntity) =>
            CheckPaymentSuccessState(checkPaymentEntity: checkPaymentEntity)));
  }
}
