import 'package:dartz/dartz.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import 'package:doctor_ack/modules/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final SendOTPUsecase sendOTPUsecase;
  final VerifyOTPUsecase verifyOTPUsecase;
  final NewPasswordUsecase newPasswordUsecase;

  ForgetPasswordCubit({
    required this.sendOTPUsecase,
    required this.verifyOTPUsecase,
    required this.newPasswordUsecase,
  }) : super(ForgetPasswordInitial());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<void> sendOTPFun() async {
    emit(SendOTPLoadingState());

    Either<Failure, GeneralEntity> response = await sendOTPUsecase(StringParams(
      string: emailController.text,
    ));

    emit(response.fold((failure) => SendOTPErrorState(message: failure.message),
        (generalEntity) => SendOTPSuccessState(generalEntity: generalEntity)));
  }

  Future<void> verifyOTPFun() async {
    emit(VerifyOTPLoadingState());

    Either<Failure, GeneralEntity> response =
        await verifyOTPUsecase(StringParams(
      string: otpController.text,
    ));

    emit(response.fold(
        (failure) => VerifyOTPErrorState(message: failure.message),
        (generalEntity) =>
            VerifyOTPSuccessState(generalEntity: generalEntity)));
  }

  Future<void> newPasswordFun() async {
    emit(NewPasswordLoadingState());

    Either<Failure, GeneralEntity> response =
        await newPasswordUsecase(NewPasswordParams(
      email: emailController.text,
      newPassword: passwordController.text,
    ));

    emit(response.fold(
        (failure) => NewPasswordErrorState(message: failure.message),
        (generalEntity) =>
            NewPasswordSuccessState(generalEntity: generalEntity)));
  }

  String suffix = IconAssets.hide;
  bool isPassword = true;

  // LoginModel? loginModel;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = IconAssets.hide;
      emit(ForgetPasswordChangePasswordVisibilityState());
    } else {
      suffix = IconAssets.hidden2;
      emit(ForgetPasswordChangePasswordVisibilityState1());
    }
    // suffix = isPassword ? IconAssets.hidden : IconAssets.hidden2;
  }
}
