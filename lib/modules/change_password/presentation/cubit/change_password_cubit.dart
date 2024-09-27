import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/assets_manager.dart';

import '../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordUsecase changePasswordUsecase;
  ChangePasswordCubit({required this.changePasswordUsecase})
      : super(InitChangePasswordState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  Future<void> changePasswordFun() async {
    emit(ChangePasswordLoadingState());

    Either<Failure, GeneralEntity> response =
        await changePasswordUsecase(ChangePasswordParams(
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
    ));

    emit(response.fold(
        (failure) => ChangePasswordErrorState(message: failure.message),
        (generalEntity) =>
            ChangePasswordSuccessState(generalEntity: generalEntity)));
  }

  String suffix = IconAssets.hide;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconAssets.hide : IconAssets.hidden2;
    emit(ChangePasswordVisibilityState());
  }

  String suffixConfirm = IconAssets.hide;
  bool isPasswordConfirm = true;

  void changePasswordConfirmVisibility() {
    isPasswordConfirm = !isPasswordConfirm;
    suffixConfirm = isPasswordConfirm ? IconAssets.hide : IconAssets.hidden2;
    emit(ChangeEyeConfirmState());
  }
}
