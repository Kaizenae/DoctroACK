import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/general_entities/create_entity.dart';
import '../../../domain/use_cases/bank_usecase.dart';
import 'edit_bank_state.dart';

class EditBankCubit extends Cubit<EditBankState> {
  final EditBankUsecase editBankUsecase;

  EditBankCubit({required this.editBankUsecase}) : super(EditBankInitial());

  static EditBankCubit get(context) => BlocProvider.of(context);

  int bankId = 0;
  String holderName = '';
  int accountNumber = 0;

  Future<void> editBankFun() async {
    emit(EditBankLoadingState());

    Either<Failure, CreateEntity> response =
        await editBankUsecase(EditBankParams(
      holderName: holderName,
      bankId: bankId,
      accountNumber: accountNumber,
    ));

    emit(response
        .fold((failure) => EditBankErrorState(message: failure.message),
            (createEntity) {
      return EditBankSuccessState(createEntity: createEntity);
    }));
  }
}
