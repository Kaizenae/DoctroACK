import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase registerUsecase;
  RegisterCubit({required this.registerUsecase}) : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerFun() async {
    emit(RegisterLoadingState());

    Either<Failure, RegisterEntity> response =
        await registerUsecase(RegisterParams(
      email: emailController.text,
      password: passwordController.text,
      userName: nameController.text,
      phone: phoneController.text,
    ));

    emit(response.fold(
        (failure) => RegisterErrorState(message: failure.message),
        (registerEntity) =>
            RegisterSuccessState(registerEntity: registerEntity)));
  }

  String suffix = IconAssets.hide;
  bool isPassword = true;
  // LoginModel? loginModel;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = IconAssets.hide;
      emit(RegisterChangePasswordVisibilityState());
    } else {
      suffix = IconAssets.hidden2;
      emit(RegisterChangePasswordVisibilityState1());
    }
    // suffix = isPassword ? IconAssets.hidden : IconAssets.hidden2;
  }
}
